part of 'sales_body.dart';

class _PaymentMethodDropdown extends StatelessWidget {
  const _PaymentMethodDropdown({required this.selectedPaymentMethod});

  final String selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedPaymentMethod,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.paymentMethod),
      ),
      items: [
        DropdownMenuItem<String>(
          value: 'all',
          child: TextApp(
            text: context.translate(LangKeys.allPaymentMethods),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
        ...paymentMethods.map((method) {
          return DropdownMenuItem<String>(
            value: method,
            child: TextApp(
              text: paymentMethodLabel(context, method),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          );
        }),
      ],
      onChanged: (value) {
        context.read<SalesCubit>().updateSelectedPaymentMethod(value ?? 'all');
      },
    );
  }
}
