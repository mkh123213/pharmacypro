import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_switch_field.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
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
  bool _isSaving = false;

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
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

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

    final success = _isEditing
        ? await context.read<MedicationsCubit>().updateMedication(medication)
        : await context.read<MedicationsCubit>().createMedication(medication);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSaveMedication),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: _isEditing
          ? context.translate(LangKeys.medicationUpdatedSuccessfully)
          : context.translate(LangKeys.medicationAddedSuccessfully),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
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
                  text: _isEditing
                      ? context.translate(LangKeys.editMedication)
                      : context.translate(LangKeys.addMedication),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: _nameController,
                  label: context.translate(LangKeys.name),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.name),
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _genericNameController,
                  label: context.translate(LangKeys.genericName),
                ),
                SizedBox(height: 12.h),
                AppDropdownField<String>(
                  value: _category,
                  label: context.translate(LangKeys.category),
                  items: medicationCategories.map((category) {
                    return AppDropdownItem<String>(
                      value: category,
                      label: medicationCategoryLabel(context, category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                ),
                SizedBox(height: 12.h),
                AppDropdownField<String>(
                  value: _dosageForm,
                  label: context.translate(LangKeys.dosageForm),
                  items: medicationForms.map((form) {
                    return AppDropdownItem<String>(
                      value: form,
                      label: medicationFormLabel(context, form),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _dosageForm = value;
                    });
                  },
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _strengthController,
                  label: context.translate(LangKeys.strength),
                  hintText: context.translate(LangKeys.strengthHint),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _manufacturerController,
                  label: context.translate(LangKeys.manufacturer),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _priceController,
                  label: context.translate(LangKeys.price),
                  isRequired: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: AppValidators.requiredNonNegativeNumber(
                    context,
                    fieldName: context.translate(LangKeys.price),
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _costPriceController,
                  label: context.translate(LangKeys.costPrice),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: AppValidators.optionalNonNegativeNumber(context),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _barcodeController,
                        label: context.translate(LangKeys.barcode),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    MedicationBarcodeScannerButton(
                      onScan: (code) {
                        setState(() {
                          _barcodeController.text = code;
                        });

                        ShowToast.showToastSuccessTop(
                          message: context.translate(
                            LangKeys.barcodeScannedSuccessfully,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _descriptionController,
                  label: context.translate(LangKeys.description),
                  maxLines: 3,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _imageUrlController,
                  label: context.translate(LangKeys.imageUrl),
                  keyboardType: TextInputType.url,
                  validator: AppValidators.optionalUrl(context),
                ),
                SizedBox(height: 12.h),
                AppSwitchField(
                  value: _requiresPrescription,
                  title: context.translate(LangKeys.requiresPrescription),
                  onChanged: (value) {
                    setState(() {
                      _requiresPrescription = value;
                    });
                  },
                ),
                AppSwitchField(
                  value: _isActive,
                  title: context.translate(LangKeys.active),
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveMedication),
                  onPressed: _isSaving ? null : _saveMedication,
                  isLoading: _isSaving,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
