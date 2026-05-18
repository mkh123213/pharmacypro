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
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotUpdatePurchaseOrderStatus),
      );
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
