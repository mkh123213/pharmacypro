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
import '../cubit/inventory_alerts_cubit.dart';
import '../cubit/inventory_alerts_state.dart';

class RemoveExpiredStockBottomSheet extends StatefulWidget {
  const RemoveExpiredStockBottomSheet({required this.item, super.key});

  final InventoryModel item;

  @override
  State<RemoveExpiredStockBottomSheet> createState() {
    return _RemoveExpiredStockBottomSheetState();
  }
}

class _RemoveExpiredStockBottomSheetState
    extends State<RemoveExpiredStockBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final reason = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final success = await context
        .read<InventoryAlertsCubit>()
        .removeExpiredStock(item: widget.item, reason: reason.text.trim());

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      final state = context.read<InventoryAlertsCubit>().state;

      String message = context.translate(LangKeys.couldNotRemoveExpiredStock);

      if (state is InventoryAlertsLoaded && state.errorMessage != null) {
        message = _buildErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.expiredStockRemovedSuccessfully),
    );

    Navigator.pop(context);
  }

  String _buildErrorMessage(BuildContext context, String errorMessage) {
    switch (errorMessage) {
      case 'inventory_item_not_found':
        return context.translate(LangKeys.inventoryItemNotFound);
      case 'expired_stock_quantity_already_zero':
        return context.translate(LangKeys.expiredStockQuantityAlreadyZero);
      default:
        return context.translate(LangKeys.couldNotRemoveExpiredStock);
    }
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
                  text: context.translate(LangKeys.removeExpiredStock),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 14.h),
                TextApp(
                  text: widget.item.medicationName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                TextApp(
                  text:
                      '${context.translate(LangKeys.currentQuantity)}: ${widget.item.quantity}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 6.h),
                TextApp(
                  text:
                      '${context.translate(LangKeys.expiryDate)}: ${widget.item.expiryDate ?? '—'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 14.h),
                AppTextField(
                  controller: reason,
                  label: context.translate(LangKeys.removalReason),
                  isRequired: true,
                  maxLines: 3,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.removalReason),
                  ),
                ),
                SizedBox(height: 14.h),
                TextApp(
                  text: context
                      .translate(LangKeys.removeExpiredStockWarning)
                      .replaceAll(
                        '{quantity}',
                        widget.item.quantity.toString(),
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.confirmRemoval),
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
