part of 'customer_orders_body.dart';

class _CustomerOrderFilters extends StatelessWidget {
  const _CustomerOrderFilters({required this.state});

  final CustomerOrdersLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;

        final search = TextField(
          decoration: InputDecoration(
            prefixIcon: AppSearchIcon(),
            hintText: context.translate(LangKeys.searchOrders),
          ),
          onChanged: context.read<CustomerOrdersCubit>().updateSearchQuery,
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
              SizedBox(width: 220.w, child: status),
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
