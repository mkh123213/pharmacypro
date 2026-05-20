part of 'inventory_body.dart';

class _StockStatusDropdown extends StatelessWidget {
  const _StockStatusDropdown({required this.selectedStatus});

  final String selectedStatus;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedStatus,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.stockStatus),
      ),
      items: [
        DropdownMenuItem<String>(
          value: 'all',
          child: TextApp(
            text: context.translate(LangKeys.allStatuses),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
        DropdownMenuItem<String>(
          value: 'healthy',
          child: TextApp(
            text: context.translate(LangKeys.healthy),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
        DropdownMenuItem<String>(
          value: 'low_stock',
          child: TextApp(
            text: context.translate(LangKeys.lowStock),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
        DropdownMenuItem<String>(
          value: 'expiring_soon',
          child: TextApp(
            text: context.translate(LangKeys.expiringSoon),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
        DropdownMenuItem<String>(
          value: 'expired',
          child: TextApp(
            text: context.translate(LangKeys.expired),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
      ],
      onChanged: (value) {
        context.read<InventoryCubit>().updateSelectedStockStatus(
          value ?? 'all',
        );
      },
    );
  }
}
