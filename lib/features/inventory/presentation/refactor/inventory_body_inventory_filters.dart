part of 'inventory_body.dart';

class _InventoryFilters extends StatelessWidget {
  const _InventoryFilters({required this.state});

  final InventoryLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;

        final search = TextField(
          decoration: InputDecoration(
            prefixIcon: AppSearchIcon(),
            hintText: context.translate(LangKeys.searchInventory),
          ),
          onChanged: context.read<InventoryCubit>().updateSearchQuery,
        );

        final branch = _BranchDropdown(
          selectedBranchId: state.selectedBranchId,
          branches: state.branches,
        );

        final stockStatus = _StockStatusDropdown(
          selectedStatus: state.selectedStockStatus,
        );

        if (wide) {
          return Row(
            children: [
              Expanded(child: search),
              SizedBox(width: 12.w),
              SizedBox(width: 220.w, child: branch),
              SizedBox(width: 12.w),
              SizedBox(width: 190.w, child: stockStatus),
            ],
          );
        }

        return Column(
          children: [
            search,
            SizedBox(height: 12.h),
            branch,
            SizedBox(height: 12.h),
            stockStatus,
          ],
        );
      },
    );
  }
}
