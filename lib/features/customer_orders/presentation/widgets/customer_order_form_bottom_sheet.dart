import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
import '../../data/models/customer_order_item_model.dart';
import '../../data/models/customer_order_model.dart';
import '../cubit/customer_orders_cubit.dart';
import '../refactor/customer_orders_constants.dart';

class CustomerOrderFormBottomSheet extends StatefulWidget {
  const CustomerOrderFormBottomSheet({
    required this.medications,
    required this.branches,
    super.key,
  });

  final List<MedicationModel> medications;
  final List<BranchModel> branches;

  @override
  State<CustomerOrderFormBottomSheet> createState() =>
      _CustomerOrderFormBottomSheetState();
}

class _CustomerOrderFormBottomSheetState
    extends State<CustomerOrderFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  String orderType = 'pickup';
  String paymentMethod = 'cash';
  String? branchId;

  final items = <CustomerOrderItemModel>[];

  bool _isSaving = false;

  double get total {
    return items.fold<double>(0, (sum, item) => sum + item.total);
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    address.dispose();
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

    setState(() {
      items.add(
        CustomerOrderItemModel(
          medicationId: medication.id,
          medicationName: medication.name,
          quantity: 1,
          unitPrice: medication.price,
          total: medication.price,
        ),
      );
    });

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.medicationAddedToOrder),
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

    if (orderType == 'delivery' && address.text.trim().isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseEnterDeliveryAddress),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final branch = widget.branches.firstWhere(
      (branch) => branch.id == branchId,
    );

    final order = CustomerOrderModel(
      id: '',
      customerName: name.text.trim(),
      customerPhone: phone.text.trim().isEmpty ? null : phone.text.trim(),
      branchId: branch.id,
      branchName: branch.name,
      deliveryAddress: orderType == 'delivery' ? address.text.trim() : null,
      orderType: orderType,
      paymentMethod: paymentMethod,
      items: items,
      totalAmount: total,
      orderNumber:
          'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );

    final success = await context
        .read<CustomerOrdersCubit>()
        .createCustomerOrder(order);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSaveOrder),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.orderCreatedSuccessfully),
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
                  text: context.translate(LangKeys.newCustomerOrder),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: name,
                  label: context.translate(LangKeys.customerName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.customerName),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: phone,
                  label: context.translate(LangKeys.phone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 10.h),
                AppDropdownField<String>(
                  value: orderType,
                  label: context.translate(LangKeys.orderType),
                  items: customerOrderTypes.map((type) {
                    return AppDropdownItem<String>(
                      value: type,
                      label: customerOrderTypeLabel(context, type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      orderType = value ?? orderType;
                    });
                  },
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
                if (orderType == 'delivery') ...[
                  SizedBox(height: 10.h),
                  AppTextField(
                    controller: address,
                    label: context.translate(LangKeys.deliveryAddress),
                    isRequired: true,
                    validator: AppValidators.required(
                      context,
                      fieldName: context.translate(LangKeys.deliveryAddress),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                AppDropdownField<String>(
                  value: paymentMethod,
                  label: context.translate(LangKeys.paymentMethod),
                  items: customerOrderPaymentMethods.map((method) {
                    return AppDropdownItem<String>(
                      value: method,
                      label: customerOrderPaymentMethodLabel(context, method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value ?? paymentMethod;
                    });
                  },
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
                  text: context.translate(LangKeys.placeOrder),
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
