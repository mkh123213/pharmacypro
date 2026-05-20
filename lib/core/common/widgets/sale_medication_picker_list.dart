import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/medications/data/models/medication_model.dart';
import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import 'sale_medication_picker_tile.dart';
import 'text_app.dart';

class SaleMedicationPickerList extends StatelessWidget {
  const SaleMedicationPickerList({
    required this.medications,
    required this.selectedMedication,
    required this.onMedicationSelected,
    super.key,
  });

  final List<MedicationModel> medications;
  final MedicationModel? selectedMedication;
  final ValueChanged<MedicationModel> onMedicationSelected;

  @override
  Widget build(BuildContext context) {
    if (medications.isEmpty) {
      return Center(
        child: TextApp(
          text: context.translate(LangKeys.noMedicationsFound),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          theme: context.textStyle,
        ),
      );
    }

    return ListView.separated(
      itemCount: medications.length,
      separatorBuilder: (_, _) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final medication = medications[index];

        return SaleMedicationPickerTile(
          medication: medication,
          isSelected: medication.id == selectedMedication?.id,
          onTap: () => onMedicationSelected(medication),
        );
      },
    );
  }
}
