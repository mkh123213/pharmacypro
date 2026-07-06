import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/common/widgets/app_search_icon.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_delete_confirmation_dialog.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/medication_model.dart';
import '../cubit/medications_cubit.dart';
import '../cubit/medications_state.dart';
import '../widgets/medication_card.dart';
import '../widgets/medication_form_bottom_sheet.dart';
import 'medication_error_mapper.dart';
import 'medications_constants.dart';

part 'medications_body_category_dropdown.dart';
part 'medications_body_empty_state_message.dart';
part 'medications_body_medication_status_dropdown.dart';
part 'medications_body_medications_error_view.dart';
part 'medications_body_medications_filters.dart';
part 'medications_body_medications_grid.dart';
part 'medications_body_open_form.dart';

class MedicationsBody extends StatelessWidget {
  const MedicationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicationsCubit, MedicationsState>(
      listenWhen: (previous, current) => current is MedicationsFailure,
      listener: (context, state) {
        if (state is MedicationsFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(medicationErrorLangKey(state.message)),
          );
        }
      },
      child: BlocBuilder<MedicationsCubit, MedicationsState>(
        builder: (context, state) {
          if (state is MedicationsLoading) {
            return const AppLoading();
          }

          if (state is MedicationsFailure) {
            return _MedicationsErrorView(
              message: context.translate(medicationErrorLangKey(state.message)),
              onRetry: () {
                context.read<MedicationsCubit>().getMedications();
              },
            );
          }

          if (state is! MedicationsLoaded) {
            return const SizedBox.shrink();
          }

          return RefreshIndicator(
            onRefresh: context.read<MedicationsCubit>().getMedications,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppPageHeader(
                    title: context.translate(LangKeys.medications),
                    subtitle: context.translate(
                      LangKeys.manageMedicationCatalog,
                    ),
                    action: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.medications.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: AppPrimaryButton(
                              text: context.translate(LangKeys.deleteAll),
                              icon: Icons.delete_outline,
                              backgroundColor: Colors.red,
                              onPressed: state.isSubmitting
                                  ? null
                                  : () async {
                                      final confirmed =
                                          await showDeleteConfirmationDialog(
                                            context: context,
                                            title: context.translate(
                                              LangKeys.deleteAllMedications,
                                            ),
                                            message: context.translate(
                                              LangKeys
                                                  .deleteAllMedicationsConfirmation,
                                            ),
                                          );

                                      if (confirmed != true || !context.mounted)
                                        return;

                                      final success = await context
                                          .read<MedicationsCubit>()
                                          .deleteAllMedications();

                                      if (!context.mounted) return;

                                      if (success) {
                                        ShowToast.showToastSuccessTop(
                                          message: context.translate(
                                            LangKeys
                                                .allMedicationsDeletedSuccessfully,
                                          ),
                                        );
                                      }
                                    },
                            ),
                          ),
                        AppPrimaryButton(
                          text: context.translate(LangKeys.addMedication),
                          icon: Icons.add,
                          onPressed: state.isSubmitting
                              ? null
                              : () {
                                  _openForm(context);
                                },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _MedicationsFilters(state: state),
                  SizedBox(height: 20.h),
                  if (state.errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: TextApp(
                        text: context.translate(
                          medicationErrorLangKey(state.errorMessage!),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle.copyWith(color: Colors.red),
                      ),
                    ),
                  if (state.medications.isEmpty)
                    AppEmptyState(
                      title: context.translate(LangKeys.noMedicationsFound),
                      message: _emptyStateMessage(context, state),
                      imagePath: context.assets.noMedicationsFound,
                    )
                  else
                    _MedicationsGrid(
                      medications: state.medications,
                      onEditPressed: (medication) {
                        _openForm(context, medication: medication);
                      },
                      onDeletePressed: (medication) async {
                        final confirmed = await showDeleteConfirmationDialog(
                          context: context,
                          title: context.translate(LangKeys.deleteMedication),
                          message: context.translate(
                            LangKeys.deleteMedicationConfirmation,
                          ),
                        );

                        if (confirmed != true || !context.mounted) return;

                        final success = await context
                            .read<MedicationsCubit>()
                            .deleteMedication(medication.id);

                        if (!context.mounted) return;

                        if (success) {
                          ShowToast.showToastSuccessTop(
                            message: context.translate(
                              LangKeys.medicationDeletedSuccessfully,
                            ),
                          );
                        }
                      },
                    ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
