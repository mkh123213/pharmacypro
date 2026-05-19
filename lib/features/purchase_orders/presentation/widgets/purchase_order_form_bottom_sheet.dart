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
import '../../../suppliers/data/models/supplier_model.dart';
import '../../data/models/purchase_order_item_model.dart';
import '../../data/models/purchase_order_model.dart';
import '../cubit/purchase_orders_cubit.dart';
import '../cubit/purchase_orders_state.dart';

class PurchaseOrderFormBottomSheet extends StatefulWidget {
  const PurchaseOrderFormBottomSheet({
    required this.suppliers,
    required this.branches,
    required this.medications,
    super.key,
  });

  final List<SupplierModel> suppliers;
  final List<BranchModel> branches;
  final List<MedicationModel> medications;

  @override
  State<PurchaseOrderFormBottomSheet> createState() =>
      _PurchaseOrderFormBottomSheetState();
}

class _PurchaseOrderFormBottomSheetState
    extends State<PurchaseOrderFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  String? supplierId;
  String? branchId;

  final orderDate = TextEditingController();
  final expectedDelivery = TextEditingController();
  final notes = TextEditingController();

  final items = <PurchaseOrderItemModel>[];

  bool _isSaving = false;

  List<SupplierModel> get _activeSuppliers {
    return widget.suppliers.where((supplier) => supplier.isActive).toList();
  }

  List<BranchModel> get _activeBranches {
    return widget.branches.where((branch) => branch.isActive).toList();
  }

  List<MedicationModel> get _activeMedications {
    return widget.medications
        .where((medication) => medication.isActive)
        .toList();
  }

  double get total {
    return items.fold<double>(0, (sum, item) => sum + item.total);
  }

  @override
  void dispose() {
    orderDate.dispose();
    expectedDelivery.dispose();
    notes.dispose();
    super.dispose();
  }

  Future<void> addPurchaseOrderItem() async {
    final activeMedications = _activeMedications;

    if (activeMedications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveMedicationsFound),
      );
      return;
    }

    final result = await showPurchaseOrderItemFormBottomSheet(
      context: context,
      medications: activeMedications,
    );

    if (result == null) return;

    setState(() {
      final existingIndex = items.indexWhere(
        (item) => item.medicationId == result.medicationId,
      );

      if (existingIndex == -1) {
        items.add(result);
        return;
      }

      final existing = items[existingIndex];
      final newQuantity = existing.quantity + result.quantity;
      final newTotal = newQuantity * result.unitCost;

      items[existingIndex] = PurchaseOrderItemModel(
        medicationId: existing.medicationId,
        medicationName: existing.medicationName,
        quantity: newQuantity,
        unitCost: result.unitCost,
        total: newTotal,
      );
    });

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.medicationAddedToPurchaseOrder),
    );
  }

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  Future<void> save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    final activeSuppliers = _activeSuppliers;
    final activeBranches = _activeBranches;

    if (activeSuppliers.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveSuppliersFound),
      );
      return;
    }

    if (activeBranches.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveBranchesFound),
      );
      return;
    }

    if (supplierId == null || branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectSupplierAndBranch),
      );
      return;
    }

    if (items.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseAddAtLeastOneItem),
      );
      return;
    }

    final dateError = AppValidators.endDateAfterStartDate(
      context,
      startDate: orderDate.text,
      endDate: expectedDelivery.text,
    );

    if (dateError != null) {
      ShowToast.showToastErrorTop(message: dateError);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final supplier = activeSuppliers.firstWhere(
      (supplier) => supplier.id == supplierId,
    );

    final branch = activeBranches.firstWhere((branch) => branch.id == branchId);

    final order = PurchaseOrderModel(
      id: '',
      supplierId: supplier.id,
      supplierName: supplier.name,
      branchId: branch.id,
      branchName: branch.name,
      orderDate: orderDate.text.trim().isEmpty ? null : orderDate.text.trim(),
      expectedDelivery: expectedDelivery.text.trim().isEmpty
          ? null
          : expectedDelivery.text.trim(),
      totalAmount: total,
      items: items,
      notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
      orderNumber:
          'PO-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );

    final success = await context
        .read<PurchaseOrdersCubit>()
        .createPurchaseOrder(order);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(message: _failureMessage());
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.purchaseOrderCreatedSuccessfully),
    );

    Navigator.pop(context);
  }

  String _failureMessage() {
    final state = context.read<PurchaseOrdersCubit>().state;

    if (state is! PurchaseOrdersLoaded) {
      return context.translate(LangKeys.couldNotSavePurchaseOrder);
    }

    final errorMessage = state.errorMessage;

    if (errorMessage == null || errorMessage.trim().isEmpty) {
      return context.translate(LangKeys.couldNotSavePurchaseOrder);
    }

    if (errorMessage == 'supplier_not_found') {
      return context.translate(LangKeys.supplierNotFound);
    }

    if (errorMessage == 'inactive_supplier') {
      return context.translate(LangKeys.inactiveSupplier);
    }

    if (errorMessage == 'branch_not_found') {
      return context.translate(LangKeys.branchNotFound);
    }

    if (errorMessage == 'inactive_branch') {
      return context.translate(LangKeys.inactiveBranch);
    }

    if (errorMessage.startsWith('medication_not_found|')) {
      final medicationName = errorMessage.split('|').last;

      return context
          .translate(LangKeys.medicationNotFound)
          .replaceAll('{medication}', medicationName);
    }

    if (errorMessage.startsWith('inactive_medication|')) {
      final medicationName = errorMessage.split('|').last;

      return context
          .translate(LangKeys.inactiveMedication)
          .replaceAll('{medication}', medicationName);
    }

    return context.translate(LangKeys.couldNotSavePurchaseOrder);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final activeSuppliers = _activeSuppliers;
    final activeBranches = _activeBranches;

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
                  text: context.translate(LangKeys.newPurchaseOrder),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppDropdownField<String>(
                  value: supplierId,
                  label: context.translate(LangKeys.supplier),
                  isRequired: true,
                  items: activeSuppliers.map((supplier) {
                    return AppDropdownItem<String>(
                      value: supplier.id,
                      label: supplier.name,
                    );
                  }).toList(),
                  onChanged: activeSuppliers.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            supplierId = value;
                          });
                        },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.supplier),
                  ),
                ),
                if (activeSuppliers.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(LangKeys.noActiveSuppliersFound),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(color: Colors.red),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                AppDropdownField<String>(
                  value: branchId,
                  label: context.translate(LangKeys.branch),
                  isRequired: true,
                  items: activeBranches.map((branch) {
                    return AppDropdownItem<String>(
                      value: branch.id,
                      label: branch.name,
                    );
                  }).toList(),
                  onChanged: activeBranches.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            branchId = value;
                          });
                        },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
                if (activeBranches.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(LangKeys.noActiveBranchesFound),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(color: Colors.red),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                AppDateField(
                  controller: orderDate,
                  label: context.translate(LangKeys.orderDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: expectedDelivery,
                  label: context.translate(LangKeys.expectedDelivery),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: TextApp(
                        text: context.translate(LangKeys.items),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: addPurchaseOrderItem,
                      icon: const Icon(Icons.add),
                      label: TextApp(
                        text: context.translate(LangKeys.add),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                  ],
                ),
                if (items.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: TextApp(
                      text: context.translate(LangKeys.noItemsAdded),
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
                        text: item.medicationName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                      subtitle: TextApp(
                        text:
                            '${context.translate(LangKeys.qty)}: ${item.quantity}'
                            ' · ${context.translate(LangKeys.unitCost)}: \$${item.unitCost.toStringAsFixed(2)}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextApp(
                            text: '\$${item.total.toStringAsFixed(2)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle,
                          ),
                          IconButton(
                            onPressed: () {
                              removeItem(index);
                            },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    );
                  }),
                AppTextField(
                  controller: notes,
                  label: context.translate(LangKeys.notes),
                  maxLines: 3,
                ),
                Divider(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: TextApp(
                        text: context.translate(LangKeys.total),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle,
                      ),
                    ),
                    TextApp(
                      text: '\$${total.toStringAsFixed(2)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.createPurchaseOrder),
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

Future<PurchaseOrderItemModel?> showPurchaseOrderItemFormBottomSheet({
  required BuildContext context,
  required List<MedicationModel> medications,
}) {
  return showModalBottomSheet<PurchaseOrderItemModel>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _PurchaseOrderItemFormBottomSheet(medications: medications);
    },
  );
}

class _PurchaseOrderItemFormBottomSheet extends StatefulWidget {
  const _PurchaseOrderItemFormBottomSheet({required this.medications});

  final List<MedicationModel> medications;

  @override
  State<_PurchaseOrderItemFormBottomSheet> createState() {
    return _PurchaseOrderItemFormBottomSheetState();
  }
}

class _PurchaseOrderItemFormBottomSheetState
    extends State<_PurchaseOrderItemFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final quantity = TextEditingController(text: '1');
  final unitCost = TextEditingController();

  String? medicationId;

  @override
  void initState() {
    super.initState();

    medicationId = widget.medications.isNotEmpty
        ? widget.medications.first.id
        : null;

    final medication = _selectedMedication;

    if (medication != null) {
      final cost = medication.costPrice ?? medication.price;
      unitCost.text = cost.toStringAsFixed(2);
    }
  }

  MedicationModel? get _selectedMedication {
    if (medicationId == null) return null;

    for (final medication in widget.medications) {
      if (medication.id == medicationId) {
        return medication;
      }
    }

    return null;
  }

  @override
  void dispose() {
    quantity.dispose();
    unitCost.dispose();
    super.dispose();
  }

  void _onMedicationChanged(String? value) {
    final medication = widget.medications.firstWhere(
      (item) => item.id == value,
    );

    final cost = medication.costPrice ?? medication.price;

    setState(() {
      medicationId = value;
      unitCost.text = cost.toStringAsFixed(2);
    });
  }

  void _saveItem() {
    if (!_formKey.currentState!.validate()) return;

    final medication = _selectedMedication;

    if (medication == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectMedication),
      );
      return;
    }

    final parsedQuantity = int.tryParse(quantity.text.trim()) ?? 1;
    final parsedUnitCost = double.tryParse(unitCost.text.trim()) ?? 0;
    final total = parsedQuantity * parsedUnitCost;

    final item = PurchaseOrderItemModel(
      medicationId: medication.id,
      medicationName: medication.name,
      quantity: parsedQuantity,
      unitCost: parsedUnitCost,
      total: total,
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
                  text: context.translate(LangKeys.addItem),
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
                  onChanged: _onMedicationChanged,
                  validator: AppValidators.required(
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
                  controller: unitCost,
                  label: context.translate(LangKeys.unitCost),
                  isRequired: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: AppValidators.requiredPositiveNumber(
                    context,
                    fieldName: context.translate(LangKeys.unitCost),
                  ),
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
