import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_delete_confirmation_dialog.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/prescription_model.dart';
import '../cubit/prescriptions_cubit.dart';
import '../cubit/prescriptions_state.dart';
import '../widgets/prescription_details_bottom_sheet.dart';
import '../widgets/prescription_form_bottom_sheet.dart';
import '../widgets/prescriptions_table.dart';
import 'prescriptions_constants.dart';

part 'prescriptions_body_branch_dropdown.dart';
part 'prescriptions_body_prescription_filters.dart';
part 'prescriptions_body_prescriptions_error_view.dart';
part 'prescriptions_body_status_dropdown.dart';

part 'prescriptions_body_build_prescription_error_message.dart';

part 'prescriptions_body_update_prescription_status.dart';
part 'prescriptions_body_open_form.dart';
class PrescriptionsBody extends StatelessWidget {
  const PrescriptionsBody({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocListener<PrescriptionsCubit, PrescriptionsState>(
      listenWhen: (previous, current) => current is PrescriptionsFailure,
      listener: (context, state) {
        if (state is PrescriptionsFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<PrescriptionsCubit, PrescriptionsState>(
        builder: (context, state) {
          if (state is PrescriptionsLoading) {
            return const AppLoading();
          }

          if (state is PrescriptionsFailure) {
            return _PrescriptionsErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<PrescriptionsCubit>().getPrescriptionsData();
              },
            );
          }

          if (state is! PrescriptionsLoaded) {
            return const SizedBox.shrink();
          }

          return RefreshIndicator(
            onRefresh: context.read<PrescriptionsCubit>().getPrescriptionsData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppPageHeader(
                    title: context.translate(LangKeys.prescriptions),
                    subtitle: context.translate(
                      LangKeys.manageAndVerifyPatientPrescriptions,
                    ),
                    action: AppPrimaryButton(
                      text: context.translate(LangKeys.newPrescription),
                      icon: Icons.add,
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              this._openForm(context, state);
                            },
                    ),
                  ),
                  SizedBox(height: 14.h),
                  _PrescriptionFilters(state: state),
                  SizedBox(height: 14.h),
                  if (state.prescriptions.isEmpty)
                    AppEmptyState(
                      title: context.translate(LangKeys.noPrescriptionsFound),
                      message:
                          state.searchQuery.trim().isEmpty &&
                              state.selectedStatus ==
                                  allPrescriptionStatusesValue &&
                              state.selectedBranchId ==
                                  allPrescriptionBranchesValue
                          ? context.translate(
                              LangKeys.createYourFirstPrescription,
                            )
                          : context.translate(
                              LangKeys.noPrescriptionsMatchYourFilters,
                            ),
                      icon: Icons.receipt_long_outlined,
                    )
                  else
                    PrescriptionsTable(
                      prescriptions: state.prescriptions,
                      isSubmitting: state.isSubmitting,
                      onView: (prescription) {
                        showPrescriptionDetailsBottomSheet(
                          context,
                          prescription,
                        );
                      },
                      onVerify: (prescription) {
                        this._updatePrescriptionStatus(
                          context: context,
                          prescription: prescription,
                          status: 'verified',
                        );
                      },
                      onReject: (prescription) {
                        this._updatePrescriptionStatus(
                          context: context,
                          prescription: prescription,
                          status: 'rejected',
                        );
                      },
                      onDispense: (prescription) {
                        this._updatePrescriptionStatus(
                          context: context,
                          prescription: prescription,
                          status: 'dispensed',
                        );
                      },
                      onDelete: (prescription) async {
                        final confirmed = await showDeleteConfirmationDialog(
                          context: context,
                          title: context.translate(LangKeys.deletePrescription),
                          message: context.translate(LangKeys.deletePrescriptionConfirmation),
                        );

                        if (confirmed != true || !context.mounted) return;

                        final success = await context.read<PrescriptionsCubit>().deletePrescription(prescription.id);

                        if (!context.mounted) return;

                        if (success) {
                          ShowToast.showToastSuccessTop(
                            message: context.translate(LangKeys.prescriptionDeletedSuccessfully),
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
