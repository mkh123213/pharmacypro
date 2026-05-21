part of 'inventory_alert_filter_bar.dart';

class _TypeDropdown extends StatelessWidget {
  const _TypeDropdown({
    required this.selectedType,
    required this.onTypeChanged,
  });

  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return AppDropdownField<String>(
      value: InventoryAlertFilterValues.normalize(selectedType),
      label: context.translate(LangKeys.alertType),
      items: InventoryAlertFilterValues.values.map((type) {
        return AppDropdownItem<String>(
          value: type,
          label: InventoryAlertFilterValues.label(context, type),
        );
      }).toList(),
      onChanged: (value) {
        onTypeChanged(InventoryAlertFilterValues.normalize(value));
      },
    );
  }
}
