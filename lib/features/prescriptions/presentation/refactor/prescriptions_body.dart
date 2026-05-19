import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
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

class PrescriptionsBody extends StatelessWidget {
  const PrescriptionsBody({super.key});

  void _openForm(BuildContext context, PrescriptionsLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<PrescriptionsCubit>(),
          child: PrescriptionFormBottomSheet(
            branches: state.branches,
            medications: state.medications,
          ),
        );
      },
    );
  }

  Future<void> _updatePrescriptionStatus({
    required BuildContext context,
    required PrescriptionModel prescription,
    required String status,
  }) async {
    final success = await context.read<PrescriptionsCubit>().updateStatus(
      prescription.id,
      status,
    );

    if (!context.mounted) return;

    if (!success) {
      final state = context.read<PrescriptionsCubit>().state;

      String message = context.translate(
        LangKeys.couldNotUpdatePrescriptionStatus,
      );

      if (state is PrescriptionsLoaded && state.errorMessage != null) {
        message = _buildPrescriptionErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    String message;

    switch (status) {
      case 'verified':
        message = context.translate(LangKeys.prescriptionVerifiedSuccessfully);
        break;
      case 'dispensed':
        message = context.translate(LangKeys.prescriptionDispensedSuccessfully);
        break;
      case 'rejected':
        message = context.translate(LangKeys.prescriptionRejected);
        break;
      default:
        message = context.translate(
          LangKeys.prescriptionStatusUpdatedSuccessfully,
        );
    }

    ShowToast.showToastSuccessTop(message: message);
  }

  String _buildPrescriptionErrorMessage(
    BuildContext context,
    String errorMessage,
  ) {
    if (errorMessage.startsWith('not_enough_stock_for_medication|')) {
      final medicationName = errorMessage
          .replaceFirst('not_enough_stock_for_medication|', '')
          .trim();

      return context
          .translate(LangKeys.notEnoughStockForMedication)
          .replaceAll('{medication}', medicationName);
    }

    switch (errorMessage) {
      case 'prescription_not_found':
        return context.translate(LangKeys.prescriptionNotFound);
      case 'prescription_already_dispensed':
        return context.translate(LangKeys.prescriptionAlreadyDispensed);
      case 'prescription_has_no_items':
        return context.translate(LangKeys.prescriptionHasNoItems);
      case 'prescription_item_missing_medication_id':
        return context.translate(LangKeys.prescriptionItemMissingMedicationId);
      case 'prescription_item_invalid_quantity':
        return context.translate(LangKeys.prescriptionItemInvalidQuantity);
      default:
        return context.translate(LangKeys.couldNotUpdatePrescriptionStatus);
    }
  }

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

          return Column(
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
                          _openForm(context, state);
                        },
                ),
              ),
              SizedBox(height: 14.h),
              LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth >= 700;

                  if (wide) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: context.translate(
                                LangKeys.searchPrescriptions,
                              ),
                            ),
                            onChanged: context
                                .read<PrescriptionsCubit>()
                                .updateSearchQuery,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        SizedBox(
                          width: 190.w,
                          child: _StatusDropdown(
                            selectedStatus: state.selectedStatus,
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: context.translate(
                            LangKeys.searchPrescriptions,
                          ),
                        ),
                        onChanged: context
                            .read<PrescriptionsCubit>()
                            .updateSearchQuery,
                      ),
                      SizedBox(height: 12.h),
                      _StatusDropdown(selectedStatus: state.selectedStatus),
                    ],
                  );
                },
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: state.prescriptions.isEmpty
                    ? AppEmptyState(
                        title: context.translate(LangKeys.noPrescriptionsFound),
                        message:
                            state.searchQuery.trim().isEmpty &&
                                state.selectedStatus ==
                                    allPrescriptionStatusesValue
                            ? context.translate(
                                LangKeys.createYourFirstPrescription,
                              )
                            : context.translate(
                                LangKeys.noPrescriptionsMatchYourFilters,
                              ),
                        icon: Icons.receipt_long_outlined,
                      )
                    : PrescriptionsTable(
                        prescriptions: state.prescriptions,
                        isSubmitting: state.isSubmitting,
                        onView: (prescription) {
                          showPrescriptionDetailsBottomSheet(
                            context,
                            prescription,
                          );
                        },
                        onVerify: (prescription) {
                          _updatePrescriptionStatus(
                            context: context,
                            prescription: prescription,
                            status: 'verified',
                          );
                        },
                        onReject: (prescription) {
                          _updatePrescriptionStatus(
                            context: context,
                            prescription: prescription,
                            status: 'rejected',
                          );
                        },
                        onDispense: (prescription) {
                          _updatePrescriptionStatus(
                            context: context,
                            prescription: prescription,
                            status: 'dispensed',
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatusDropdown extends StatelessWidget {
  const _StatusDropdown({required this.selectedStatus});

  final String selectedStatus;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedStatus,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.status),
      ),
      items: prescriptionStatuses.map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: TextApp(
            text: prescriptionStatusLabel(context, status),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        );
      }).toList(),
      onChanged: (value) {
        context.read<PrescriptionsCubit>().updateSelectedStatus(
          value ?? allPrescriptionStatusesValue,
        );
      },
    );
  }
}

class _PrescriptionsErrorView extends StatelessWidget {
  const _PrescriptionsErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: Colors.red.shade400),
            SizedBox(height: 12.h),
            TextApp(
              text: message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            SizedBox(height: 16.h),
            AppPrimaryButton(
              text: context.translate(LangKeys.retry),
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
