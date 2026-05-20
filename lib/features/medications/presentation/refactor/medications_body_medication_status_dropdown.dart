part of 'medications_body.dart';

class _MedicationStatusDropdown extends StatelessWidget {
  const _MedicationStatusDropdown({required this.selectedStatus});

  final String selectedStatus;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedStatus,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.status),
      ),
      items: medicationStatusOptions.map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: TextApp(
            text: medicationStatusLabel(context, status),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;

        context.read<MedicationsCubit>().updateSelectedStatus(value);
      },
    );
  }
}
