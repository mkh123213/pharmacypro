import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/purchase_order_model.dart';
import '../refactor/purchase_orders_constants.dart';

void showPurchaseOrderDetailsBottomSheet(
  BuildContext context,
  PurchaseOrderModel order,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _PurchaseOrderDetailsBottomSheet(order: order);
    },
  );
}

class _PurchaseOrderDetailsBottomSheet extends StatelessWidget {
  const _PurchaseOrderDetailsBottomSheet({required this.order});

  final PurchaseOrderModel order;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.88,
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextApp(
                      text: context
                          .translate(LangKeys.purchaseOrderTitle)
                          .replaceAll(
                            '{number}',
                            order.orderNumber ?? order.id,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  AppStatusChip(
                    label: purchaseOrderStatusLabel(context, order.status),
                    type: _statusType(order.status),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _DetailsSection(
                children: [
                  _DetailsRow(
                    label: context.translate(LangKeys.supplier),
                    value: order.supplierName ?? '-',
                  ),
                  _DetailsRow(
                    label: context.translate(LangKeys.branch),
                    value: order.branchName ?? '-',
                  ),
                  _DetailsRow(
                    label: context.translate(LangKeys.orderDate),
                    value: _emptyFallback(order.orderDate),
                  ),
                  _DetailsRow(
                    label: context.translate(LangKeys.expectedDelivery),
                    value: _emptyFallback(order.expectedDelivery),
                  ),
                  _DetailsRow(
                    label: context.translate(LangKeys.total),
                    value: '\$${order.totalAmount.toStringAsFixed(2)}',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              TextApp(
                text: context.translate(LangKeys.items),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.h),
              if (order.items.isEmpty)
                TextApp(
                  text: context.translate(LangKeys.noItemsAdded),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                )
              else
                ...order.items.map((item) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextApp(
                            text: item.medicationName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          _DetailsRow(
                            label: context.translate(LangKeys.quantity),
                            value: item.quantity.toString(),
                          ),
                          _DetailsRow(
                            label: context.translate(LangKeys.unitCost),
                            value: '\$${item.unitCost.toStringAsFixed(2)}',
                          ),
                          _DetailsRow(
                            label: context.translate(LangKeys.total),
                            value: '\$${item.total.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              if (order.notes != null && order.notes!.trim().isNotEmpty) ...[
                SizedBox(height: 8.h),
                TextApp(
                  text: context.translate(LangKeys.notes),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                TextApp(
                  text: order.notes!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _emptyFallback(String? value) {
    if (value == null || value.trim().isEmpty) return '-';
    return value;
  }

  AppStatusChipType _statusType(String status) {
    switch (status) {
      case 'draft':
        return AppStatusChipType.neutral;
      case 'sent':
        return AppStatusChipType.info;
      case 'confirmed':
        return AppStatusChipType.warning;
      case 'received':
        return AppStatusChipType.success;
      case 'cancelled':
        return AppStatusChipType.error;
      default:
        return AppStatusChipType.neutral;
    }
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(children: children),
      ),
    );
  }
}

class _DetailsRow extends StatelessWidget {
  const _DetailsRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130.w,
            child: TextApp(
              text: label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextApp(
              text: value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
