part of 'inventory_alerts_body.dart';

extension InventoryAlertsBodyOpenRemoveExpiredStockSheet on InventoryAlertsBody {
void _openRemoveExpiredStockSheet(
    BuildContext context,
    InventoryAlertModel alert,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<InventoryAlertsCubit>(),
          child: RemoveExpiredStockBottomSheet(item: alert.inventoryItem),
        );
      },
    );
  }
}
