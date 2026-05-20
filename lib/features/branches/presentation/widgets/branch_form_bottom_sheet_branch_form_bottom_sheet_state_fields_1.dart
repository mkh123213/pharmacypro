part of 'branch_form_bottom_sheet.dart';

extension BranchFormBottomSheetStateFields1 on _BranchFormBottomSheetState {
  List<Widget> _buildBranchFormBottomSheetFields1(BuildContext context) {
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
                      ? context.translate(LangKeys.editBranch)
                      : context.translate(LangKeys.addBranch),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: name,
                  label: context.translate(LangKeys.branchName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.branchName),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: city,
                  label: context.translate(LangKeys.city),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: address,
                  label: context.translate(LangKeys.address),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.address),
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
                AppTextField(
                  controller: email,
                  label: context.translate(LangKeys.email),
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.optionalEmail(context),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: manager,
                  label: context.translate(LangKeys.managerName),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: hours,
                  label: context.translate(LangKeys.openingHours),
                ),
                SizedBox(height: 8.h),
    ];
  }
}
