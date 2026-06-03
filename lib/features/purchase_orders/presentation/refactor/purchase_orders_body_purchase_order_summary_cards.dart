part of 'purchase_orders_body.dart';

class _PurchaseOrderSummaryCards extends StatelessWidget {
  const _PurchaseOrderSummaryCards({required this.orders});

  final List<PurchaseOrderModel> orders;

  int _countByStatus(String status) {
    return orders.where((order) => order.status == status).length;
  }

  double get _totalValue {
    return orders.fold<double>(0, (sum, order) => sum + order.totalAmount);
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      _PurchaseOrderSummaryCardData(
        title: context.translate(LangKeys.draft),
        value: _countByStatus('draft').toString(),
        icon: Icons.edit_note,
      ),
      _PurchaseOrderSummaryCardData(
        title: context.translate(LangKeys.sent),
        value: _countByStatus('sent').toString(),
        icon: Icons.send_outlined,
      ),
      _PurchaseOrderSummaryCardData(
        title: context.translate(LangKeys.confirmed),
        value: _countByStatus('confirmed').toString(),
        icon: Icons.verified_outlined,
      ),
      _PurchaseOrderSummaryCardData(
        title: context.translate(LangKeys.received),
        value: _countByStatus('received').toString(),
        icon: Icons.inventory_2_outlined,
      ),
      _PurchaseOrderSummaryCardData(
        title: context.translate(LangKeys.cancelled),
        value: _countByStatus('cancelled').toString(),
        icon: Icons.cancel_outlined,
      ),
      _PurchaseOrderSummaryCardData(
        title: context.translate(LangKeys.totalValue),
        value: '\$${_totalValue.toStringAsFixed(2)}',
        icon: Icons.attach_money,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1100
            ? 6
            : constraints.maxWidth >= 800
            ? 3
            : constraints.maxWidth >= 520
            ? 2
            : 1;

        return GridView.count(
          crossAxisCount: count,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: count == 1 ? 3.3 : 2.15,
          children: cards.map((card) {
            return _PurchaseOrderSummaryCard(data: card);
          }).toList(),
        );
      },
    );
  }
}
