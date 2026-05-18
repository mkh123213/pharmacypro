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

  void addFirstMedication() {
    if (widget.medications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noMedicationsFound),
      );
      return;
    }

    final medication = widget.medications.first;
    final cost = medication.costPrice ?? medication.price;

    setState(() {
      items.add(
        PurchaseOrderItemModel(
          medicationId: medication.id,
          medicationName: medication.name,
          quantity: 1,
          unitCost: cost,
          total: cost,
        ),
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

    final supplier = widget.suppliers.firstWhere(
      (supplier) => supplier.id == supplierId,
    );

    final branch = widget.branches.firstWhere(
      (branch) => branch.id == branchId,
    );

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
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSavePurchaseOrder),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.purchaseOrderCreatedSuccessfully),
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
                  items: widget.suppliers.map((supplier) {
                    return AppDropdownItem<String>(
                      value: supplier.id,
                      label: supplier.name,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      supplierId = value;
                    });
                  },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.supplier),
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
                      onPressed: addFirstMedication,
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
                        text: context
                            .translate(LangKeys.qtyValue)
                            .replaceAll('{qty}', item.quantity.toString()),
                        maxLines: 1,
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
