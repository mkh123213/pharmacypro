part of 'purchase_orders_table.dart';

class _PurchaseOrdersCards extends StatelessWidget {
  const _PurchaseOrdersCards({
    required this.orders,
    required this.onView,
    required this.onEdit,
    required this.onNextStatus,
    required this.onCancel,
    required this.isSubmitting,
  });

  final List<PurchaseOrderModel> orders;
  final ValueChanged<PurchaseOrderModel> onView;
  final ValueChanged<PurchaseOrderModel> onEdit;
  final ValueChanged<PurchaseOrderModel> onNextStatus;
  final ValueChanged<PurchaseOrderModel> onCancel;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: orders.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final order = orders[index];

        return _PurchaseOrderCard(
          order: order,
          onView: onView,
          onEdit: onEdit,
          onNextStatus: onNextStatus,
          onCancel: onCancel,
          isSubmitting: isSubmitting,
        );
      },
    );
  }
}
