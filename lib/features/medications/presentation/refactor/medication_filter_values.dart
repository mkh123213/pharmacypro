const String allMedicationCategoriesValue = 'all';
const String allMedicationStatusesValue = 'all';
const String activeMedicationStatusValue = 'active';
const String inactiveMedicationStatusValue = 'inactive';

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

const medicationCategoryOptions = [
  allMedicationCategoriesValue,
  ...medicationCategories,
];

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

const medicationStatusOptions = [
  allMedicationStatusesValue,
  activeMedicationStatusValue,
  inactiveMedicationStatusValue,
];
