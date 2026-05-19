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
import '../../data/models/inventory_model.dart';
import '../cubit/inventory_cubit.dart';

class InventoryFormBottomSheet extends StatefulWidget {
  const InventoryFormBottomSheet({
    required this.medications,
    required this.branches,
    this.item,
    super.key,
  });

  final List<MedicationModel> medications;
  final List<BranchModel> branches;
  final InventoryModel? item;

  @override
  State<InventoryFormBottomSheet> createState() =>
      _InventoryFormBottomSheetState();
}

class _InventoryFormBottomSheetState extends State<InventoryFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late String? medicationId =
      widget.item?.medicationId ??
      (widget.medications.isNotEmpty ? widget.medications.first.id : null);

  late String? branchId =
      widget.item?.branchId ??
      (widget.branches.isNotEmpty ? widget.branches.first.id : null);

  late final TextEditingController quantity;
  late final TextEditingController min;
  late final TextEditingController batch;
  late final TextEditingController expiry;
  late final TextEditingController location;

  bool _isSaving = false;

  bool get _isEditing => widget.item != null;

  @override
  void initState() {
    super.initState();

    quantity = TextEditingController(
      text: widget.item?.quantity.toString() ?? '0',
    );
    min = TextEditingController(
      text: widget.item?.minStockLevel.toString() ?? '10',
    );
    batch = TextEditingController(text: widget.item?.batchNumber ?? '');
    expiry = TextEditingController(text: widget.item?.expiryDate ?? '');
    location = TextEditingController(text: widget.item?.locationInStore ?? '');
  }

  @override
  void dispose() {
    quantity.dispose();
    min.dispose();
    batch.dispose();
    expiry.dispose();
    location.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    if (medicationId == null || branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectMedicationAndBranch),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final medication = widget.medications.firstWhere(
      (item) => item.id == medicationId,
    );

    final branch = widget.branches.firstWhere((item) => item.id == branchId);

    final model = InventoryModel(
      id: widget.item?.id ?? '',
      medicationId: medication.id,
      medicationName: medication.name,
      branchId: branch.id,
      branchName: branch.name,
      quantity: _isEditing
          ? widget.item!.quantity
          : int.tryParse(quantity.text.trim()) ?? 0,
      minStockLevel: int.tryParse(min.text.trim()) ?? 10,
      batchNumber: batch.text.trim().isEmpty ? null : batch.text.trim(),
      expiryDate: expiry.text.trim().isEmpty ? null : expiry.text.trim(),
      locationInStore: location.text.trim().isEmpty
          ? null
          : location.text.trim(),
    );

    final success = _isEditing
        ? await context.read<InventoryCubit>().updateInventory(model)
        : await context.read<InventoryCubit>().createInventory(model);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSaveInventoryItem),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: _isEditing
          ? context.translate(LangKeys.inventoryItemUpdatedSuccessfully)
          : context.translate(LangKeys.inventoryItemAddedSuccessfully),
    );

    if (model.quantity <= model.minStockLevel) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.itemBelowMinimumStockLevel),
      );
    }

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
                      ? context.translate(LangKeys.editInventoryItem)
                      : context.translate(LangKeys.addInventoryItem),
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
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.medication),
                  ),
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
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: quantity,
                  label: context.translate(LangKeys.quantity),
                  isRequired: !_isEditing,
                  readOnly: _isEditing,
                  enabled: true,
                  keyboardType: TextInputType.number,
                  suffixIcon: _isEditing
                      ? Tooltip(
                          message: context.translate(
                            LangKeys.useAdjustStockToChangeQuantity,
                          ),
                          child: const Icon(Icons.lock_outline),
                        )
                      : null,
                  validator: _isEditing
                      ? null
                      : AppValidators.requiredNonNegativeNumber(
                          context,
                          fieldName: context.translate(LangKeys.quantity),
                        ),
                ),
                if (_isEditing) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(
                        LangKeys.useAdjustStockToChangeQuantity,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                AppTextField(
                  controller: min,
                  label: context.translate(LangKeys.minStockLevel),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  validator: AppValidators.requiredNonNegativeNumber(
                    context,
                    fieldName: context.translate(LangKeys.minStockLevel),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: batch,
                  label: context.translate(LangKeys.batchNumber),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: expiry,
                  label: context.translate(LangKeys.expiryDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: location,
                  label: context.translate(LangKeys.locationInStore),
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveInventoryItem),
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
