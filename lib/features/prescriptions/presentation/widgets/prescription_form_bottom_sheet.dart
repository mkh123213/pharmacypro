import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_date_field.dart';
import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../data/models/prescription_item_model.dart';
import '../../data/models/prescription_model.dart';
import '../cubit/prescriptions_cubit.dart';

class PrescriptionFormBottomSheet extends StatefulWidget {
  const PrescriptionFormBottomSheet({
    required this.branches,
    required this.medications,
    super.key,
  });

  final List<BranchModel> branches;
  final List<MedicationModel> medications;

  @override
  State<PrescriptionFormBottomSheet> createState() {
    return _PrescriptionFormBottomSheetState();
  }
}

class _PrescriptionFormBottomSheetState
    extends State<PrescriptionFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final patient = TextEditingController();
  final phone = TextEditingController();
  final doctor = TextEditingController();
  final license = TextEditingController();
  final issueDate = TextEditingController();
  final expiryDate = TextEditingController();
  final notes = TextEditingController();

  String? branchId;
  final items = <PrescriptionItemModel>[];

  bool _isSaving = false;

  @override
  void dispose() {
    patient.dispose();
    phone.dispose();
    doctor.dispose();
    license.dispose();
    issueDate.dispose();
    expiryDate.dispose();
    notes.dispose();
    super.dispose();
  }

  Future<void> _addPrescriptionItem() async {
    if (widget.medications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noMedicationsFound),
      );
      return;
    }

    final result = await showPrescriptionItemFormBottomSheet(
      context: context,
      medications: widget.medications,
    );

    if (result == null) return;

    setState(() {
      items.add(result);
    });

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.medicationAddedToPrescription),
    );
  }

  void _removePrescriptionItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  Future<void> save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    if (branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectBranch),
      );
      return;
    }

    if (items.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(
          LangKeys.pleaseAddAtLeastOnePrescriptionItem,
        ),
      );
      return;
    }

    final dateError = AppValidators.endDateAfterStartDate(
      context,
      startDate: issueDate.text,
      endDate: expiryDate.text,
    );

    if (dateError != null) {
      ShowToast.showToastErrorTop(message: dateError);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final branch = widget.branches.firstWhere(
      (branch) => branch.id == branchId,
    );

    final prescription = PrescriptionModel(
      id: '',
      patientName: patient.text.trim(),
      patientPhone: phone.text.trim().isEmpty ? null : phone.text.trim(),
      doctorName: doctor.text.trim().isEmpty ? null : doctor.text.trim(),
      doctorLicense: license.text.trim().isEmpty ? null : license.text.trim(),
      issueDate: issueDate.text.trim().isEmpty ? null : issueDate.text.trim(),
      expiryDate: expiryDate.text.trim().isEmpty
          ? null
          : expiryDate.text.trim(),
      branchId: branch.id,
      branchName: branch.name,
      items: items,
      notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
      prescriptionNumber:
          'RX-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );

    final success = await context.read<PrescriptionsCubit>().createPrescription(
      prescription,
    );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSavePrescription),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.prescriptionCreatedSuccessfully),
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
                  text: context.translate(LangKeys.newPrescription),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: patient,
                  label: context.translate(LangKeys.patientName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.patientName),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: phone,
                  label: context.translate(LangKeys.patientPhone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: doctor,
                  label: context.translate(LangKeys.doctorName),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: license,
                  label: context.translate(LangKeys.doctorLicense),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: issueDate,
                  label: context.translate(LangKeys.issueDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: expiryDate,
                  label: context.translate(LangKeys.expiryDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 10.h),
                AppDropdownField<String>(
                  value: branchId,
                  label: context.translate(LangKeys.branch),
                  isRequired: true,
                  items: widget.branches.map((branch) {
                    return AppDropdownItem<String>(
                      value: branch.id,
                      label: branch.name,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      branchId = value;
                    });
                  },
                  validator: AppValidators.requiredDropdown<String>(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
                SizedBox(height: 14.h),
                _PrescriptionItemsSection(
                  items: items,
                  onAddPressed: _addPrescriptionItem,
                  onRemovePressed: _removePrescriptionItem,
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: notes,
                  label: context.translate(LangKeys.notes),
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.createPrescription),
                  onPressed: _isSaving ? null : save,
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

class _PrescriptionItemsSection extends StatelessWidget {
  const _PrescriptionItemsSection({
    required this.items,
    required this.onAddPressed,
    required this.onRemovePressed,
  });

  final List<PrescriptionItemModel> items;
  final VoidCallback onAddPressed;
  final ValueChanged<int> onRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextApp(
                text: context.translate(LangKeys.prescriptionItems),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add),
              label: TextApp(
                text: context.translate(LangKeys.addItem),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        if (items.isEmpty)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextApp(
              text: context.translate(LangKeys.noPrescriptionItems),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          )
        else
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: TextApp(
                text: item.medicationName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
              subtitle: TextApp(
                text:
                    '${context.translate(LangKeys.qty)}: ${item.quantity ?? 0}'
                    ' · ${item.dosage ?? context.translate(LangKeys.noDosage)}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
              trailing: IconButton(
                onPressed: () {
                  onRemovePressed(index);
                },
                icon: const Icon(Icons.delete_outline),
              ),
            );
          }),
      ],
    );
  }
}

Future<PrescriptionItemModel?> showPrescriptionItemFormBottomSheet({
  required BuildContext context,
  required List<MedicationModel> medications,
}) {
  return showModalBottomSheet<PrescriptionItemModel>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _PrescriptionItemFormBottomSheet(medications: medications);
    },
  );
}

class _PrescriptionItemFormBottomSheet extends StatefulWidget {
  const _PrescriptionItemFormBottomSheet({required this.medications});

  final List<MedicationModel> medications;

  @override
  State<_PrescriptionItemFormBottomSheet> createState() {
    return _PrescriptionItemFormBottomSheetState();
  }
}

class _PrescriptionItemFormBottomSheetState
    extends State<_PrescriptionItemFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final quantity = TextEditingController(text: '1');
  final dosage = TextEditingController();
  final instructions = TextEditingController();

  String? medicationId;

  @override
  void dispose() {
    quantity.dispose();
    dosage.dispose();
    instructions.dispose();
    super.dispose();
  }

  void _saveItem() {
    if (!_formKey.currentState!.validate()) return;

    if (medicationId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectMedication),
      );
      return;
    }

    final medication = widget.medications.firstWhere(
      (item) => item.id == medicationId,
    );

    final item = PrescriptionItemModel(
      medicationId: medication.id,
      medicationName: medication.name,
      quantity: int.tryParse(quantity.text.trim()) ?? 1,
      dosage: dosage.text.trim().isEmpty ? null : dosage.text.trim(),
      instructions: instructions.text.trim().isEmpty
          ? null
          : instructions.text.trim(),
    );

    Navigator.pop(context, item);
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
                  text: context.translate(LangKeys.addPrescriptionItem),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppDropdownField<String>(
                  value: medicationId,
                  label: context.translate(LangKeys.medication),
                  isRequired: true,
                  items: widget.medications.map((medication) {
                    return AppDropdownItem<String>(
                      value: medication.id,
                      label: medication.name,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      medicationId = value;
                    });
                  },
                  validator: AppValidators.requiredDropdown<String>(
                    context,
                    fieldName: context.translate(LangKeys.medication),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: quantity,
                  label: context.translate(LangKeys.quantity),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  validator: AppValidators.requiredPositiveNumber(
                    context,
                    fieldName: context.translate(LangKeys.quantity),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: dosage,
                  label: context.translate(LangKeys.dosage),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: instructions,
                  label: context.translate(LangKeys.instructions),
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.addItem),
                  onPressed: _saveItem,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
