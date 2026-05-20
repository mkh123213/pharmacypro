part of 'sales_table.dart';

class _SalesCards extends StatelessWidget {
  const _SalesCards({required this.sales});

  final List<SaleModel> sales;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: sales.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final sale = sales[index];

        return Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextApp(
                        text: _saleNumber(sale),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    AppStatusChip(
                      label: _statusLabel(context, sale.status),
                      type: _statusType(sale.status),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                _InfoRow(
                  label: context.translate(LangKeys.date),
                  value: _dateText(sale),
                ),
                _InfoRow(
                  label: context.translate(LangKeys.customer),
                  value:
                      sale.customerName ?? context.translate(LangKeys.walkIn),
                ),
                _InfoRow(
                  label: context.translate(LangKeys.branch),
                  value: sale.branchName ?? '-',
                ),
                _InfoRow(
                  label: context.translate(LangKeys.items),
                  value: context
                      .translate(LangKeys.itemsCount)
                      .replaceAll('{count}', sale.items.length.toString()),
                ),
                _InfoRow(
                  label: context.translate(LangKeys.payment),
                  value: _paymentLabel(context, sale.paymentMethod),
                ),
                _InfoRow(
                  label: context.translate(LangKeys.total),
                  value: '\$${sale.totalAmount.toStringAsFixed(2)}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
