const allMedicationCategoriesValue = 'all';

const medicationCategories = [
  'analgesic',
  'antibiotic',
  'antiviral',
  'antifungal',
  'cardiovascular',
  'diabetes',
  'respiratory',
  'gastrointestinal',
  'dermatology',
  'vitamins_supplements',
  'otc',
  'other',
];

const medicationCategoryOptions = [allMedicationCategoriesValue, ...medicationCategories];

const medicationForms = [
  'tablet',
  'capsule',
  'syrup',
  'injection',
  'cream',
  'drops',
  'inhaler',
  'patch',
  'suppository',
  'other',
];

String formatMedicationLabel(String value) {
  if (value == allMedicationCategoriesValue) return 'All Categories';
  return value.split('_').map((word) => word.isEmpty ? word : word[0].toUpperCase() + word.substring(1)).join(' ');
}
