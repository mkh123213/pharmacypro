part of 'inventory_body.dart';

extension InventoryBodyOpenForm on InventoryBody {
void _openForm(
    BuildContext context,
    InventoryLoaded state, {
    InventoryModel? item,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<InventoryCubit>(),
          child: InventoryFormBottomSheet(
            medications: state.medications,
            branches: state.branches,
            item: item,
          ),
        );
      },
    );
  }
}
