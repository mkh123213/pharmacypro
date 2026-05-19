import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../data/models/inventory_model.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';

class InventoryAdjustStockBottomSheet extends StatefulWidget {
  const InventoryAdjustStockBottomSheet({required this.item, super.key});

  final InventoryModel item;

  @override
  State<InventoryAdjustStockBottomSheet> createState() {
    return _InventoryAdjustStockBottomSheetState();
  }
}

class _InventoryAdjustStockBottomSheetState
    extends State<InventoryAdjustStockBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final quantityChange = TextEditingController();
  final reason = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    quantityChange.dispose();
    reason.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    final change = int.tryParse(quantityChange.text.trim()) ?? 0;

    if (change == 0) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.adjustmentQuantityCannotBeZero),
      );
      return;
    }

    if (widget.item.quantity + change < 0) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.quantityCannotGoBelowZero),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final success = await context.read<InventoryCubit>().adjustInventoryStock(
      item: widget.item,
      quantityChange: change,
      reason: reason.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      final state = context.read<InventoryCubit>().state;

      String message = context.translate(LangKeys.couldNotAdjustStock);

      if (state is InventoryLoaded && state.errorMessage != null) {
        message = _buildErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.stockAdjustedSuccessfully),
    );

    Navigator.pop(context);
  }

  String _buildErrorMessage(BuildContext context, String errorMessage) {
    switch (errorMessage) {
      case 'inventory_item_not_found':
        return context.translate(LangKeys.inventoryItemNotFound);
      case 'quantity_cannot_go_below_zero':
        return context.translate(LangKeys.quantityCannotGoBelowZero);
      default:
        return context.translate(LangKeys.couldNotAdjustStock);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final newQuantityPreview =
        widget.item.quantity + (int.tryParse(quantityChange.text.trim()) ?? 0);

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
                  text: context.translate(LangKeys.adjustStock),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                TextApp(
                  text: widget.item.medicationName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 4.h),
                TextApp(
                  text:
                      '${context.translate(LangKeys.currentQuantity)}: ${widget.item.quantity}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: quantityChange,
                  label: context.translate(LangKeys.adjustmentQuantity),
                  hintText: '-5 or 10',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  validator: AppValidators.requiredNumber(
                    context,
                    fieldName: context.translate(LangKeys.adjustmentQuantity),
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: reason,
                  label: context.translate(LangKeys.adjustmentReason),
                  isRequired: true,
                  maxLines: 3,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.adjustmentReason),
                  ),
                ),
                SizedBox(height: 12.h),
                TextApp(
                  text:
                      '${context.translate(LangKeys.newQuantity)}: $newQuantityPreview',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: newQuantityPreview < 0 ? Colors.red : null,
                  ),
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveAdjustment),
                  onPressed: _isSaving ? null : _save,
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
