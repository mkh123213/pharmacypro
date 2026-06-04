part of 'medications_body.dart';

extension MedicationsBodyEmptyStateMessage on MedicationsBody {
String _emptyStateMessage(BuildContext context, MedicationsLoaded state) {
    final noFilters = state.searchQuery.trim().isEmpty &&
        state.selectedCategory == allMedicationCategoriesValue &&
        state.selectedStatus == allMedicationStatusesValue;

    return noFilters
        ? context.translate(LangKeys.addYourFirstMedication)
        : context.translate(LangKeys.noMedicationsMatchYourFilters);
  }
}
