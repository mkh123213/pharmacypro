import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../data/models/medication_model.dart';
import '../cubit/medications_cubit.dart';
import '../refactor/medications_constants.dart';
import 'medication_barcode_scanner_button.dart';

class MedicationFormBottomSheet extends StatefulWidget {
  const MedicationFormBottomSheet({this.medication, super.key});

  final MedicationModel? medication;

  @override
  State<MedicationFormBottomSheet> createState() =>
      _MedicationFormBottomSheetState();
}

class _MedicationFormBottomSheetState extends State<MedicationFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _genericNameController;
  late final TextEditingController _strengthController;
  late final TextEditingController _manufacturerController;
  late final TextEditingController _priceController;
  late final TextEditingController _costPriceController;
  late final TextEditingController _barcodeController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imageUrlController;

  String? _category;
  String? _dosageForm;

  late bool _requiresPrescription;
  late bool _isActive;

  bool get _isEditing => widget.medication != null;

  @override
  void initState() {
    super.initState();

    final medication = widget.medication;

    _nameController = TextEditingController(text: medication?.name ?? '');
    _genericNameController = TextEditingController(
      text: medication?.genericName ?? '',
    );
    _strengthController = TextEditingController(
      text: medication?.strength ?? '',
    );
    _manufacturerController = TextEditingController(
      text: medication?.manufacturer ?? '',
    );
    _priceController = TextEditingController(
      text: medication?.price.toString() ?? '',
    );
    _costPriceController = TextEditingController(
      text: medication?.costPrice?.toString() ?? '',
    );
    _barcodeController = TextEditingController(text: medication?.barcode ?? '');
    _descriptionController = TextEditingController(
      text: medication?.description ?? '',
    );
    _imageUrlController = TextEditingController(
      text: medication?.imageUrl ?? '',
    );

    _category = medication?.category;
    _dosageForm = medication?.dosageForm;
    _requiresPrescription = medication?.requiresPrescription ?? false;
    _isActive = medication?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genericNameController.dispose();
    _strengthController.dispose();
    _manufacturerController.dispose();
    _priceController.dispose();
    _costPriceController.dispose();
    _barcodeController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveMedication() async {
    if (!_formKey.currentState!.validate()) return;

    final medication = MedicationModel(
      id: widget.medication?.id ?? '',
      name: _nameController.text.trim(),
      genericName: _genericNameController.text.trim().isEmpty
          ? null
          : _genericNameController.text.trim(),
      category: _category,
      dosageForm: _dosageForm,
      strength: _strengthController.text.trim().isEmpty
          ? null
          : _strengthController.text.trim(),
      manufacturer: _manufacturerController.text.trim().isEmpty
          ? null
          : _manufacturerController.text.trim(),
      barcode: _barcodeController.text.trim().isEmpty
          ? null
          : _barcodeController.text.trim(),
      requiresPrescription: _requiresPrescription,
      price: double.tryParse(_priceController.text.trim()) ?? 0,
      costPrice: _costPriceController.text.trim().isEmpty
          ? null
          : double.tryParse(_costPriceController.text.trim()),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      imageUrl: _imageUrlController.text.trim().isEmpty
          ? null
          : _imageUrlController.text.trim(),
      isActive: _isActive,
      createdAt: widget.medication?.createdAt,
      updatedAt: widget.medication?.updatedAt,
    );

    if (_isEditing) {
      await context.read<MedicationsCubit>().updateMedication(medication);
    } else {
      await context.read<MedicationsCubit>().createMedication(medication);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 16.h,
        bottom: bottomInset + 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
                SizedBox(height: 18.h),
                TextApp(
                  text: _isEditing ? 'Edit Medication' : 'Add Medication',
                  theme: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20.h),

                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name *'),
                  validator: _requiredValidator,
                ),
                SizedBox(height: 12.h),

                TextFormField(
                  controller: _genericNameController,
                  decoration: const InputDecoration(labelText: 'Generic Name'),
                ),
                SizedBox(height: 12.h),

                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: medicationCategories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(formatMedicationLabel(category)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                ),
                SizedBox(height: 12.h),

                DropdownButtonFormField<String>(
                  value: _dosageForm,
                  decoration: const InputDecoration(labelText: 'Dosage Form'),
                  items: medicationForms.map((form) {
                    return DropdownMenuItem<String>(
                      value: form,
                      child: Text(formatMedicationLabel(form)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _dosageForm = value;
                    });
                  },
                ),
                SizedBox(height: 12.h),

                TextFormField(
                  controller: _strengthController,
                  decoration: const InputDecoration(
                    labelText: 'Strength',
                    hintText: 'e.g. 500mg',
                  ),
                ),
                SizedBox(height: 12.h),

                TextFormField(
                  controller: _manufacturerController,
                  decoration: const InputDecoration(labelText: 'Manufacturer'),
                ),
                SizedBox(height: 12.h),

                TextFormField(
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(labelText: 'Price *'),
                  validator: _priceValidator,
                ),
                SizedBox(height: 12.h),

                TextFormField(
                  controller: _costPriceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(labelText: 'Cost Price'),
                ),
                SizedBox(height: 12.h),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _barcodeController,
                        decoration: const InputDecoration(labelText: 'Barcode'),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    MedicationBarcodeScannerButton(
                      onScan: (code) {
                        setState(() {
                          _barcodeController.text = code;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 12.h),

                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                SizedBox(height: 12.h),

                SwitchListTile(
                  value: _requiresPrescription,
                  onChanged: (value) {
                    setState(() {
                      _requiresPrescription = value;
                    });
                  },
                  title: const Text('Requires Prescription'),
                  contentPadding: EdgeInsets.zero,
                ),

                SwitchListTile(
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                  title: const Text('Active'),
                  contentPadding: EdgeInsets.zero,
                ),

                SizedBox(height: 16.h),

                AppPrimaryButton(
                  text: 'Save Medication',
                  onPressed: _saveMedication,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    return null;
  }

  String? _priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    final price = double.tryParse(value.trim());

    if (price == null) {
      return 'Enter a valid number';
    }

    if (price < 0) {
      return 'Price cannot be negative';
    }

    return null;
  }
}
