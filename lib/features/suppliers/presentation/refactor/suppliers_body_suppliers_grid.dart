part of 'suppliers_body.dart';

class _SuppliersGrid extends StatelessWidget {
  const _SuppliersGrid({required this.suppliers, required this.onEditPressed, required this.onDeletePressed});

  final List<SupplierModel> suppliers;
  final ValueChanged<SupplierModel> onEditPressed;
  final ValueChanged<SupplierModel> onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1100
            ? 3
            : constraints.maxWidth >= 700
            ? 2
            : 1;

        return GridView.builder(
          itemCount: suppliers.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.h,
            childAspectRatio: count == 1 ? 1.52 : 1.08,
          ),
          itemBuilder: (_, index) {
            final supplier = suppliers[index];

            return SupplierCard(
              supplier: supplier,
              onEditPressed: () {
                onEditPressed(supplier);
              },
              onDeletePressed: () {
                onDeletePressed(supplier);
              },
            );
          },
        );
      },
    );
  }
}
