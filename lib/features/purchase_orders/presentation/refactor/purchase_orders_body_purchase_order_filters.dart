part of 'purchase_orders_body.dart';

class _PurchaseOrderFilters extends StatelessWidget {
  const _PurchaseOrderFilters({required this.state});

  final PurchaseOrdersLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;

        final search = TextFormField(
          initialValue: state.searchQuery,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: context.translate(LangKeys.searchPurchaseOrders),
          ),
          onChanged: context.read<PurchaseOrdersCubit>().updateSearchQuery,
        );

        final status = _StatusDropdown(selectedStatus: state.selectedStatus);

        final branch = _BranchDropdown(
          selectedBranchId: state.selectedBranchId,
          branches: state.branches,
        );

        if (wide) {
          return Row(
            children: [
              Expanded(child: search),
              SizedBox(width: 12.w),
              SizedBox(width: 190.w, child: status),
              SizedBox(width: 12.w),
              SizedBox(width: 220.w, child: branch),
            ],
          );
        }

        return Column(
          children: [
            search,
            SizedBox(height: 12.h),
            status,
            SizedBox(height: 12.h),
            branch,
          ],
        );
      },
    );
  }
}
