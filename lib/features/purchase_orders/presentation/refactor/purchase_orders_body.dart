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
import '../../data/models/purchase_order_model.dart';
import '../cubit/purchase_orders_cubit.dart';
import '../cubit/purchase_orders_state.dart';
import '../widgets/purchase_order_details_bottom_sheet.dart';
import '../widgets/purchase_order_form_bottom_sheet.dart';
import '../widgets/purchase_orders_table.dart';
import 'purchase_orders_constants.dart';

class PurchaseOrdersBody extends StatelessWidget {
  const PurchaseOrdersBody({super.key});

  void _openForm(BuildContext context, PurchaseOrdersLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<PurchaseOrdersCubit>(),
          child: PurchaseOrderFormBottomSheet(
            suppliers: state.suppliers,
            branches: state.branches,
            medications: state.medications,
          ),
        );
      },
    );
  }

  Future<void> _confirmCancelPurchaseOrder(
    BuildContext context,
    PurchaseOrderModel order,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: TextApp(
            text: context.translate(LangKeys.cancelPurchaseOrder),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
          content: TextApp(
            text: context.translate(LangKeys.cancelPurchaseOrderConfirmation),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: TextApp(
                text: context.translate(LangKeys.no),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: TextApp(
                text: context.translate(LangKeys.yesCancel),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    await _updatePurchaseOrderStatus(
      context: context,
      order: order,
      status: 'cancelled',
    );
  }

  Future<void> _updatePurchaseOrderStatus({
    required BuildContext context,
    required PurchaseOrderModel order,
    required String status,
  }) async {
    final success = await context.read<PurchaseOrdersCubit>().updateStatus(
      order.id,
      status,
    );

    if (!context.mounted) return;

    if (!success) {
      final state = context.read<PurchaseOrdersCubit>().state;

      String message = context.translate(
        LangKeys.couldNotUpdatePurchaseOrderStatus,
      );

      if (state is PurchaseOrdersLoaded && state.errorMessage != null) {
        message = _buildPurchaseOrderErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    String message;

    switch (status) {
      case 'sent':
        message = context.translate(LangKeys.purchaseOrderSentSuccessfully);
        break;
      case 'confirmed':
        message = context.translate(
          LangKeys.purchaseOrderConfirmedSuccessfully,
        );
        break;
      case 'received':
        message = context.translate(LangKeys.purchaseOrderReceivedSuccessfully);
        break;
      case 'cancelled':
        message = context.translate(LangKeys.purchaseOrderCancelled);
        break;
      default:
        message = context.translate(
          LangKeys.purchaseOrderStatusUpdatedSuccessfully,
        );
    }

    ShowToast.showToastSuccessTop(message: message);
  }

  String _buildPurchaseOrderErrorMessage(
    BuildContext context,
    String errorMessage,
  ) {
    if (errorMessage == 'supplier_not_found') {
      return context.translate(LangKeys.supplierNotFound);
    }

    if (errorMessage == 'inactive_supplier') {
      return context.translate(LangKeys.inactiveSupplier);
    }

    if (errorMessage == 'branch_not_found') {
      return context.translate(LangKeys.branchNotFound);
    }

    if (errorMessage == 'inactive_branch') {
      return context.translate(LangKeys.inactiveBranch);
    }

    if (errorMessage.startsWith('medication_not_found|')) {
      final medicationName = errorMessage
          .replaceFirst('medication_not_found|', '')
          .trim();

      return context
          .translate(LangKeys.medicationNotFound)
          .replaceAll('{medication}', medicationName);
    }

    if (errorMessage.startsWith('inactive_medication|')) {
      final medicationName = errorMessage
          .replaceFirst('inactive_medication|', '')
          .trim();

      return context
          .translate(LangKeys.inactiveMedication)
          .replaceAll('{medication}', medicationName);
    }

    if (errorMessage == 'purchase_order_not_found') {
      return context.translate(LangKeys.purchaseOrderNotFound);
    }

    if (errorMessage == 'purchase_order_already_received') {
      return context.translate(LangKeys.purchaseOrderAlreadyReceived);
    }

    if (errorMessage == 'purchase_order_already_cancelled') {
      return context.translate(LangKeys.purchaseOrderAlreadyCancelled);
    }

    if (errorMessage == 'cannot_cancel_received_purchase_order') {
      return context.translate(LangKeys.cannotCancelReceivedPurchaseOrder);
    }

    if (errorMessage == 'invalid_purchase_order_status_transition') {
      return context.translate(LangKeys.invalidPurchaseOrderStatusTransition);
    }

    if (errorMessage == 'purchase_order_has_no_items') {
      return context.translate(LangKeys.purchaseOrderHasNoItems);
    }

    return context.translate(LangKeys.couldNotUpdatePurchaseOrderStatus);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchaseOrdersCubit, PurchaseOrdersState>(
      listenWhen: (previous, current) => current is PurchaseOrdersFailure,
      listener: (context, state) {
        if (state is PurchaseOrdersFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<PurchaseOrdersCubit, PurchaseOrdersState>(
        builder: (context, state) {
          if (state is PurchaseOrdersLoading) {
            return const AppLoading();
          }

          if (state is PurchaseOrdersFailure) {
            return _PurchaseOrdersErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<PurchaseOrdersCubit>().getPurchaseOrdersData();
              },
            );
          }

          if (state is! PurchaseOrdersLoaded) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppPageHeader(
                title: context.translate(LangKeys.purchaseOrders),
                subtitle: context.translate(
                  LangKeys.manageSupplierPurchaseOrders,
                ),
                action: AppPrimaryButton(
                  text: context.translate(LangKeys.newOrder),
                  icon: Icons.add,
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          _openForm(context, state);
                        },
                ),
              ),
              SizedBox(height: 14.h),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: context.translate(LangKeys.searchPurchaseOrders),
                ),
                onChanged: context
                    .read<PurchaseOrdersCubit>()
                    .updateSearchQuery,
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: state.purchaseOrders.isEmpty
                    ? AppEmptyState(
                        title: context.translate(
                          LangKeys.noPurchaseOrdersFound,
                        ),
                        message: state.searchQuery.trim().isEmpty
                            ? context.translate(
                                LangKeys.createYourFirstPurchaseOrder,
                              )
                            : context.translate(
                                LangKeys.noPurchaseOrdersMatchYourSearch,
                              ),
                        icon: Icons.receipt_long_outlined,
                      )
                    : PurchaseOrdersTable(
                        orders: state.purchaseOrders,
                        isSubmitting: state.isSubmitting,
                        onView: (order) {
                          showPurchaseOrderDetailsBottomSheet(context, order);
                        },
                        onNextStatus: (order) {
                          final nextStatus =
                              nextPurchaseOrderStatus[order.status];

                          if (nextStatus == null) return;

                          _updatePurchaseOrderStatus(
                            context: context,
                            order: order,
                            status: nextStatus,
                          );
                        },
                        onCancel: (order) {
                          _confirmCancelPurchaseOrder(context, order);
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

class _PurchaseOrdersErrorView extends StatelessWidget {
  const _PurchaseOrdersErrorView({
    required this.message,
    required this.onRetry,
  });

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
