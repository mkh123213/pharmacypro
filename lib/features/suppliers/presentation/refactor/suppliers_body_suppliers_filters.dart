part of 'suppliers_body.dart';

class _SuppliersFilters extends StatelessWidget {
  const _SuppliersFilters({required this.state});

  final SuppliersLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 700;

        final search = TextFormField(
          initialValue: state.searchQuery,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: context.translate(LangKeys.searchSuppliers),
          ),
          onChanged: context.read<SuppliersCubit>().updateSearchQuery,
        );

        final status = _SupplierStatusDropdown(
          selectedStatus: state.selectedStatus,
        );

        if (wide) {
          return Row(
            children: [
              Expanded(child: search),
              SizedBox(width: 12.w),
              SizedBox(width: 200.w, child: status),
            ],
          );
        }

        return Column(
          children: [
            search,
            SizedBox(height: 12.h),
            status,
          ],
        );
      },
    );
  }
}
