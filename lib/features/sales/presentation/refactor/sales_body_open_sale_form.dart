part of 'sales_body.dart';

extension SalesBodyOpenSaleForm on SalesBody {
void _openSaleForm(BuildContext context, SalesLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SalesCubit>(),
          child: SaleFormBottomSheet(
            medications: state.medications,
            branches: state.branches,
          ),
        );
      },
    );
  }
}
