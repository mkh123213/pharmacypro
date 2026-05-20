part of 'supplier_form_bottom_sheet.dart';

extension SupplierFormBottomSheetStateFields1 on _SupplierFormBottomSheetState {
  List<Widget> _buildSupplierFormBottomSheetFields1(BuildContext context) {
    return [
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
    ];
  }
}
