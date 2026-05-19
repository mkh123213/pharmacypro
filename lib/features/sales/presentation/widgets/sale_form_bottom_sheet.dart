import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/common/widgets/sale_medication_picker_bottom_sheet.dart';
import 'package:pharmacypro/features/sales/presentation/cubit/sales_state.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../data/models/sale_item_model.dart';
import '../../data/models/sale_model.dart';
import '../cubit/sales_cubit.dart';
import 'sale_summary_card.dart';

class SaleFormBottomSheet extends StatefulWidget {
  const SaleFormBottomSheet({
    required this.medications,
    required this.branches,
    super.key,
  });

  final List<MedicationModel> medications;
  final List<BranchModel> branches;

  @override
  State<SaleFormBottomSheet> createState() => _SaleFormBottomSheetState();
}

class _SaleFormBottomSheetState extends State<SaleFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  String? branchId;
  String payment = 'cash';

  final customer = TextEditingController();
  final phone = TextEditingController();
  final discount = TextEditingController();

  final items = <SaleItemModel>[];

  bool _isSaving = false;

  double get subtotal {
    return items.fold<double>(0, (sum, item) => sum + item.total);
  }

  double get discountAmount {
    return double.tryParse(discount.text.trim()) ?? 0;
  }

  double get total {
    final value = subtotal - discountAmount;
    return value < 0 ? 0 : value;
  }

  @override
  void dispose() {
    customer.dispose();
    phone.dispose();
    discount.dispose();
    super.dispose();
  }

  Future<void> addItem() async {
    if (widget.medications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noMedicationsFound),
      );
      return;
    }

    final result = await showSaleMedicationPickerBottomSheet(
      context: context,
      medications: widget.medications,
    );

    if (result == null) return;

    final medication = result.medication;
    final quantity = result.quantity;

    final existingIndex = items.indexWhere(
      (item) => item.medicationId == medication.id,
    );

    setState(() {
      if (existingIndex == -1) {
        items.add(
          SaleItemModel(
            medicationId: medication.id,
            medicationName: medication.name,
            quantity: quantity,
            unitPrice: medication.price,
            total: medication.price * quantity,
          ),
        );
      } else {
        final existing = items[existingIndex];
        final newQuantity = existing.quantity + quantity;

        items[existingIndex] = SaleItemModel(
          medicationId: existing.medicationId,
          medicationName: existing.medicationName,
          quantity: newQuantity,
          unitPrice: existing.unitPrice,
          total: existing.unitPrice * newQuantity,
        );
      }
    });

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.medicationAddedToSale),
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

    if (branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectBranch),
      );
      return;
    }

    if (items.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseAddAtLeastOneItem),
      );
      return;
    }

    if (discountAmount > subtotal) {
      ShowToast.showToastErrorTop(
        message: context.translate(
          LangKeys.discountCannotBeGreaterThanSubtotal,
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final branch = widget.branches.firstWhere((item) => item.id == branchId);

    final sale = SaleModel(
      id: '',
      branchId: branch.id,
      branchName: branch.name,
      customerName: customer.text.trim().isEmpty ? null : customer.text.trim(),
      customerPhone: phone.text.trim().isEmpty ? null : phone.text.trim(),
      items: items,
      subtotal: subtotal,
      discount: discountAmount,
      totalAmount: total,
      paymentMethod: payment,
      saleNumber:
          'S-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );

    final success = await context.read<SalesCubit>().createSale(sale);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      final state = context.read<SalesCubit>().state;

      String message = context.translate(LangKeys.couldNotCompleteSale);

      if (state is SalesLoaded && state.errorMessage != null) {
        message = _buildSaleErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.saleCompletedSuccessfully),
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
                  text: context.translate(LangKeys.newSale),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
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
                SizedBox(height: 10.h),
                AppDropdownField<String>(
                  value: payment,
                  label: context.translate(LangKeys.paymentMethod),
                  items: paymentMethods.map((method) {
                    return AppDropdownItem<String>(
                      value: method,
                      label: paymentMethodLabel(context, method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      payment = value ?? payment;
                    });
                  },
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: customer,
                  label: context.translate(LangKeys.customerName),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: phone,
                  label: context.translate(LangKeys.customerPhone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: addItem,
                    icon: const Icon(Icons.add),
                    label: TextApp(
                      text: context.translate(LangKeys.addItem),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
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
                            '${item.quantity} x \$${item.unitPrice.toStringAsFixed(2)}',
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
                            icon: Icon(Icons.close, size: 18.sp),
                          ),
                        ],
                      ),
                    );
                  }),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: discount,
                  label: context.translate(LangKeys.discount),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: AppValidators.optionalNonNegativeNumber(context),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 12.h),
                SaleSummaryCard(
                  subtotal: subtotal,
                  discount: discountAmount,
                  total: total,
                ),
                SizedBox(height: 12.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.completeSale),
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

String _buildSaleErrorMessage(BuildContext context, String errorMessage) {
  if (errorMessage.startsWith('not_enough_stock_for_medication|')) {
    final medicationName = errorMessage
        .replaceFirst('not_enough_stock_for_medication|', '')
        .trim();

    return context
        .translate(LangKeys.notEnoughStockForMedication)
        .replaceAll('{medication}', medicationName);
  }

  return context.translate(LangKeys.couldNotCompleteSale);
}

const paymentMethods = ['cash', 'card', 'insurance', 'online'];

String paymentMethodLabel(BuildContext context, String value) {
  switch (value) {
    case 'cash':
      return context.translate(LangKeys.cash);
    case 'card':
      return context.translate(LangKeys.card);
    case 'insurance':
      return context.translate(LangKeys.insurance);
    case 'online':
      return context.translate(LangKeys.online);
    default:
      return value;
  }
}
