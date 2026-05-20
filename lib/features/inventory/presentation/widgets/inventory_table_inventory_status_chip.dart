part of 'inventory_table.dart';

class _InventoryStatusChip extends StatelessWidget {
  const _InventoryStatusChip({required this.item});

  final InventoryModel item;

  @override
  Widget build(BuildContext context) {
    if (item.isExpired) {
      return AppStatusChip(
        label: context.translate(LangKeys.expired),
        type: AppStatusChipType.error,
      );
    }

    if (item.isExpiringSoon) {
      return AppStatusChip(
        label: context.translate(LangKeys.expiringSoon),
        type: AppStatusChipType.warning,
      );
    }

    if (item.isLowStock) {
      return AppStatusChip(
        label: context.translate(LangKeys.lowStock),
        type: AppStatusChipType.error,
      );
    }

    return AppStatusChip(
      label: context.translate(LangKeys.ok),
      type: AppStatusChipType.success,
    );
  }
}
