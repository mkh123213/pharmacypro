part of 'customer_orders_body.dart';

class _StatusDropdown extends StatelessWidget {
  const _StatusDropdown({required this.selectedStatus});

  final String selectedStatus;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedStatus,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.status),
      ),
      items: customerOrderStatuses.map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: TextApp(
            text: customerOrderStatusLabel(context, status),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        );
      }).toList(),
      onChanged: (value) {
        context.read<CustomerOrdersCubit>().updateSelectedStatus(
          value ?? allCustomerOrderStatusesValue,
        );
      },
    );
  }
}
