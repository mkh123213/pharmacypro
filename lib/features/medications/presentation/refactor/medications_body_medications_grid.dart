part of 'medications_body.dart';

class _MedicationsGrid extends StatelessWidget {
  const _MedicationsGrid({
    required this.medications,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  final List<MedicationModel> medications;
  final ValueChanged<MedicationModel> onEditPressed;
  final ValueChanged<MedicationModel> onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1200
            ? 4
            : constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 600
            ? 2
            : 1;

        return GridView.builder(
          itemCount: medications.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.h,
            childAspectRatio: count == 1 ? 1.55 : .90,
          ),
          itemBuilder: (_, index) {
            final medication = medications[index];

            return MedicationCard(
              medication: medication,
              onEditPressed: () {
                onEditPressed(medication);
              },
              onDeletePressed: () {
                onDeletePressed(medication);
              },
            );
          },
        );
      },
    );
  }
}
