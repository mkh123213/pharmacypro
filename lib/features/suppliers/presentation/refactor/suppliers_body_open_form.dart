part of 'suppliers_body.dart';

extension SuppliersBodyOpenForm on SuppliersBody {
void _openForm(BuildContext context, {SupplierModel? supplier}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SuppliersCubit>(),
          child: SupplierFormBottomSheet(supplier: supplier),
        );
      },
    );
  }
}
