part of 'inventory_body.dart';

extension InventoryBodyOpenAdjustStock on InventoryBody {
void _openAdjustStock(BuildContext context, InventoryModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<InventoryCubit>(),
          child: InventoryAdjustStockBottomSheet(item: item),
        );
      },
    );
  }
}
