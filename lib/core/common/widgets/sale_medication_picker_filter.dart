import '../../../features/medications/data/models/medication_model.dart';

class SaleMedicationPickerFilter {
  const SaleMedicationPickerFilter._();

  static List<MedicationModel> apply({
    required List<MedicationModel> medications,
    required String query,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return medications;

    return medications.where((medication) {
      return _matchesMedication(medication, normalizedQuery);
    }).toList();
  }

  static bool _matchesMedication(MedicationModel medication, String query) {
    return medication.name.toLowerCase().contains(query) ||
        (medication.genericName?.toLowerCase().contains(query) ?? false) ||
        (medication.barcode?.toLowerCase().contains(query) ?? false);
  }
}
