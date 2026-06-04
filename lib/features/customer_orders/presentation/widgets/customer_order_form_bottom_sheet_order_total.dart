part of 'customer_order_form_bottom_sheet.dart';

class _OrderTotal extends StatelessWidget {
  const _OrderTotal({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Expanded(
              child: TextApp(
                text: context.translate(LangKeys.total),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            TextApp(
              text: '\$${total.toStringAsFixed(2)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
