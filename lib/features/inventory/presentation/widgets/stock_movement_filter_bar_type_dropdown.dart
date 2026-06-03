part of 'stock_movement_filter_bar.dart';

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
      value: selectedType,
      label: context.translate(LangKeys.movementType),
      items: stockMovementTypes.map((type) {
        return AppDropdownItem<String>(
          value: type,
          label: stockMovementTypeLabel(context, type),
        );
      }).toList(),
      onChanged: (value) {
        onTypeChanged(value ?? 'all');
      },
    );
  }
}
