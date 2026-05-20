part of 'purchase_orders_body.dart';

extension PurchaseOrdersBodyConfirmReceivePurchaseOrder on PurchaseOrdersBody {
Future<void> _confirmReceivePurchaseOrder(
    BuildContext context,
    PurchaseOrderModel order,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: TextApp(
            text: context.translate(LangKeys.receivePurchaseOrder),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
          content: TextApp(
            text: context.translate(LangKeys.receivePurchaseOrderConfirmation),
            maxLines: 4,
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
                text: context.translate(LangKeys.yesReceive),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    await this._updatePurchaseOrderStatus(
      context: context,
      order: order,
      status: 'received',
    );
  }
}
