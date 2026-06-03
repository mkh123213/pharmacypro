part of 'medications_body.dart';

class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({required this.selectedCategory});

  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedCategory,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.category),
      ),
      items: medicationCategoryOptions.map((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: TextApp(
            text: medicationCategoryLabel(context, category),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;

        context.read<MedicationsCubit>().updateSelectedCategory(value);
      },
    );
  }
}
