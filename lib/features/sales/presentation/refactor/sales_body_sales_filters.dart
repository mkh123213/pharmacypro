part of 'sales_body.dart';

class _SalesFilters extends StatelessWidget {
  const _SalesFilters({required this.state});

  final SalesLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;

        final search = TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: context.translate(LangKeys.searchSales),
          ),
          onChanged: context.read<SalesCubit>().updateSearchQuery,
        );

        final payment = _PaymentMethodDropdown(
          selectedPaymentMethod: state.selectedPaymentMethod,
        );

        if (wide) {
          return Row(
            children: [
              Expanded(child: search),
              SizedBox(width: 12.w),
              SizedBox(width: 220.w, child: payment),
            ],
          );
        }

        return Column(
          children: [
            search,
            SizedBox(height: 12.h),
            payment,
          ],
        );
      },
    );
  }
}
