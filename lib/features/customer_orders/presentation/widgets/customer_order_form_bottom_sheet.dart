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
import '../cubit/customer_orders_state.dart';

class CustomerOrderFormBottomSheet extends StatefulWidget {
  const CustomerOrderFormBottomSheet({
    required this.medications,
    required this.branches,
    super.key,
  });

  final List<MedicationModel> medications;
  final List<BranchModel> branches;

  @override
  State<CustomerOrderFormBottomSheet> createState() {
    return _CustomerOrderFormBottomSheetState();
  }
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

  List<BranchModel> get activeBranches {
    return widget.branches.where((branch) => branch.isActive).toList();
  }

  List<MedicationModel> get activeMedications {
    return widget.medications
        .where((medication) => medication.isActive)
        .toList();
  }

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
    final availableMedications = activeMedications;

    if (availableMedications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveMedicationsFound),
      );
      return;
    }

    final medication = availableMedications.first;

    final existingIndex = items.indexWhere(
      (item) => item.medicationId == medication.id,
    );

    setState(() {
      if (existingIndex == -1) {
        items.add(
          CustomerOrderItemModel(
            medicationId: medication.id,
            medicationName: medication.name,
            quantity: 1,
            unitPrice: medication.price,
            total: medication.price,
          ),
        );
      } else {
        final existing = items[existingIndex];
        final newQuantity = existing.quantity + 1;

        items[existingIndex] = CustomerOrderItemModel(
          medicationId: existing.medicationId,
          medicationName: existing.medicationName,
          quantity: newQuantity,
          unitPrice: existing.unitPrice,
          total: existing.unitPrice * newQuantity,
        );
      }
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

    final selectedBranch = activeBranches.where(
      (branch) => branch.id == branchId,
    );

    if (selectedBranch.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.inactiveBranch),
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

    final branch = selectedBranch.first;

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
      final state = context.read<CustomerOrdersCubit>().state;

      String message = context.translate(LangKeys.couldNotCreateOrder);

      if (state is CustomerOrdersLoaded && state.errorMessage != null) {
        message = _buildCustomerOrderErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
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
    final availableBranches = activeBranches;

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
                  text: context.translate(LangKeys.newOrder),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
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
                  label: context.translate(LangKeys.customerPhone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 10.h),
                AppDropdownField<String>(
                  value: orderType,
                  label: context.translate(LangKeys.orderType),
                  items: orderTypes.map((type) {
                    return AppDropdownItem<String>(
                      value: type,
                      label: orderTypeLabel(context, type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      orderType = value ?? orderType;
                    });
                  },
                ),
                if (orderType == 'delivery') ...[
                  SizedBox(height: 10.h),
                  AppTextField(
                    controller: address,
                    label: context.translate(LangKeys.deliveryAddress),
                    isRequired: true,
                    maxLines: 2,
                    validator: AppValidators.required(
                      context,
                      fieldName: context.translate(LangKeys.deliveryAddress),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                if (availableBranches.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: TextApp(
                      text: context.translate(LangKeys.noActiveBranchesFound),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  AppDropdownField<String>(
                    value: branchId,
                    label: context.translate(LangKeys.branch),
                    isRequired: true,
                    items: availableBranches.map((branch) {
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
                  value: paymentMethod,
                  label: context.translate(LangKeys.paymentMethod),
                  items: paymentMethods.map((method) {
                    return AppDropdownItem<String>(
                      value: method,
                      label: paymentMethodLabel(context, method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value ?? paymentMethod;
                    });
                  },
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: OutlinedButton.icon(
                    onPressed: activeMedications.isEmpty
                        ? null
                        : addFirstMedication,
                    icon: const Icon(Icons.add),
                    label: TextApp(
                      text: context.translate(LangKeys.addItem),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ),
                ),
                if (activeMedications.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(
                        LangKeys.noActiveMedicationsFound,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
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
                SizedBox(height: 12.h),
                _OrderTotal(total: total),
                SizedBox(height: 14.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.createOrder),
                  onPressed: _isSaving || availableBranches.isEmpty
                      ? null
                      : save,
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

class _OrderTotal extends StatelessWidget {
  const _OrderTotal({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Expanded(
              child: TextApp(
                text: context.translate(LangKeys.total),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            TextApp(
              text: '\$${total.toStringAsFixed(2)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

String _buildCustomerOrderErrorMessage(
  BuildContext context,
  String errorMessage,
) {
  if (errorMessage == 'branch_not_found') {
    return context.translate(LangKeys.branchNotFound);
  }

  if (errorMessage == 'inactive_branch') {
    return context.translate(LangKeys.inactiveBranch);
  }

  if (errorMessage.startsWith('medication_not_found|')) {
    final medicationName = errorMessage
        .replaceFirst('medication_not_found|', '')
        .trim();

    return context
        .translate(LangKeys.medicationNotFound)
        .replaceAll('{medication}', medicationName);
  }

  if (errorMessage.startsWith('inactive_medication|')) {
    final medicationName = errorMessage
        .replaceFirst('inactive_medication|', '')
        .trim();

    return context
        .translate(LangKeys.inactiveMedication)
        .replaceAll('{medication}', medicationName);
  }

  if (errorMessage.startsWith('not_enough_stock_for_medication|')) {
    final medicationName = errorMessage
        .replaceFirst('not_enough_stock_for_medication|', '')
        .trim();

    return context
        .translate(LangKeys.notEnoughStockForMedication)
        .replaceAll('{medication}', medicationName);
  }

  if (errorMessage.startsWith('expired_stock_for_medication|')) {
    final medicationName = errorMessage
        .replaceFirst('expired_stock_for_medication|', '')
        .trim();

    return context
        .translate(LangKeys.expiredStockForMedication)
        .replaceAll('{medication}', medicationName);
  }

  return context.translate(LangKeys.couldNotCreateOrder);
}

const orderTypes = ['pickup', 'delivery'];

String orderTypeLabel(BuildContext context, String value) {
  switch (value) {
    case 'pickup':
      return context.translate(LangKeys.pickup);
    case 'delivery':
      return context.translate(LangKeys.delivery);
    default:
      return value;
  }
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
