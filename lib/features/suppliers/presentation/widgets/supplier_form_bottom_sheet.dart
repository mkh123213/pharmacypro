import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_switch_field.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../data/models/supplier_model.dart';
import '../cubit/suppliers_cubit.dart';

class SupplierFormBottomSheet extends StatefulWidget {
  const SupplierFormBottomSheet({this.supplier, super.key});

  final SupplierModel? supplier;

  @override
  State<SupplierFormBottomSheet> createState() =>
      _SupplierFormBottomSheetState();
}

class _SupplierFormBottomSheetState extends State<SupplierFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController contact;
  late final TextEditingController phone;
  late final TextEditingController email;
  late final TextEditingController address;
  late final TextEditingController paymentTerms;
  late final TextEditingController notes;

  late bool isActive;
  bool _isSaving = false;

  bool get _isEditing => widget.supplier != null;

  @override
  void initState() {
    super.initState();

    final supplier = widget.supplier;

    name = TextEditingController(text: supplier?.name ?? '');
    contact = TextEditingController(text: supplier?.contactPerson ?? '');
    phone = TextEditingController(text: supplier?.phone ?? '');
    email = TextEditingController(text: supplier?.email ?? '');
    address = TextEditingController(text: supplier?.address ?? '');
    paymentTerms = TextEditingController(text: supplier?.paymentTerms ?? '');
    notes = TextEditingController(text: supplier?.notes ?? '');
    isActive = supplier?.isActive ?? true;
  }

  @override
  void dispose() {
    name.dispose();
    contact.dispose();
    phone.dispose();
    email.dispose();
    address.dispose();
    paymentTerms.dispose();
    notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final supplier = SupplierModel(
      id: widget.supplier?.id ?? '',
      name: name.text.trim(),
      contactPerson: contact.text.trim().isEmpty ? null : contact.text.trim(),
      phone: phone.text.trim().isEmpty ? null : phone.text.trim(),
      email: email.text.trim().isEmpty ? null : email.text.trim(),
      address: address.text.trim().isEmpty ? null : address.text.trim(),
      paymentTerms: paymentTerms.text.trim().isEmpty
          ? null
          : paymentTerms.text.trim(),
      notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
      isActive: isActive,
      createdAt: widget.supplier?.createdAt,
      updatedAt: widget.supplier?.updatedAt,
    );

    final success = _isEditing
        ? await context.read<SuppliersCubit>().updateSupplier(supplier)
        : await context.read<SuppliersCubit>().createSupplier(supplier);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSaveSupplier),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: _isEditing
          ? context.translate(LangKeys.supplierUpdatedSuccessfully)
          : context.translate(LangKeys.supplierAddedSuccessfully),
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
                      ? context.translate(LangKeys.editSupplier)
                      : context.translate(LangKeys.addSupplier),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: name,
                  label: context.translate(LangKeys.companyName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.companyName),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: contact,
                  label: context.translate(LangKeys.contactPerson),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: phone,
                  label: context.translate(LangKeys.phone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: email,
                  label: context.translate(LangKeys.email),
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.optionalEmail(context),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: paymentTerms,
                  label: context.translate(LangKeys.paymentTerms),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: address,
                  label: context.translate(LangKeys.address),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: notes,
                  label: context.translate(LangKeys.notes),
                  maxLines: 3,
                ),
                SizedBox(height: 8.h),
                AppSwitchField(
                  value: isActive,
                  title: context.translate(LangKeys.active),
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveSupplier),
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
