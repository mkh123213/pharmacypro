import 'package:flutter/material.dart';

import '../../data/models/medication_model.dart';

class MedicationFormController {
  MedicationFormController(MedicationModel? medication)
    : isEditing = medication != null,
      sourceMedication = medication,
      nameController = TextEditingController(text: medication?.name ?? ''),
      genericNameController = TextEditingController(
        text: medication?.genericName ?? '',
      ),
      strengthController = TextEditingController(
        text: medication?.strength ?? '',
      ),
      manufacturerController = TextEditingController(
        text: medication?.manufacturer ?? '',
      ),
      priceController = TextEditingController(
        text: medication?.price.toString() ?? '',
      ),
      costPriceController = TextEditingController(
        text: medication?.costPrice?.toString() ?? '',
      ),
      barcodeController = TextEditingController(text: medication?.barcode ?? ''),
      descriptionController = TextEditingController(
        text: medication?.description ?? '',
      ),
      imageUrlController = TextEditingController(
        text: medication?.imageUrl ?? '',
      ),
      category = medication?.category,
      dosageForm = medication?.dosageForm,
      requiresPrescription = medication?.requiresPrescription ?? false,
      isActive = medication?.isActive ?? true;

  final bool isEditing;
  final MedicationModel? sourceMedication;
  final TextEditingController nameController;
  final TextEditingController genericNameController;
  final TextEditingController strengthController;
  final TextEditingController manufacturerController;
  final TextEditingController priceController;
  final TextEditingController costPriceController;
  final TextEditingController barcodeController;
  final TextEditingController descriptionController;
  final TextEditingController imageUrlController;

  String? category;
  String? dosageForm;
  bool requiresPrescription;
  bool isActive;

  MedicationModel toMedication() {
    return MedicationModel(
      id: sourceMedication?.id ?? '',
      name: nameController.text,
      genericName: genericNameController.text,
      category: category,
      dosageForm: dosageForm,
      strength: strengthController.text,
      manufacturer: manufacturerController.text,
      barcode: barcodeController.text,
      requiresPrescription: requiresPrescription,
      price: double.tryParse(priceController.text.trim()) ?? -1,
      costPrice: _optionalDouble(costPriceController.text),
      description: descriptionController.text,
      imageUrl: imageUrlController.text,
      isActive: isActive,
      createdAt: sourceMedication?.createdAt,
      updatedAt: sourceMedication?.updatedAt,
    );
  }

  void dispose() {
    nameController.dispose();
    genericNameController.dispose();
    strengthController.dispose();
    manufacturerController.dispose();
    priceController.dispose();
    costPriceController.dispose();
    barcodeController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
  }

  double? _optionalDouble(String value) {
    final text = value.trim();

    if (text.isEmpty) return null;

    return double.tryParse(text);
  }
}
