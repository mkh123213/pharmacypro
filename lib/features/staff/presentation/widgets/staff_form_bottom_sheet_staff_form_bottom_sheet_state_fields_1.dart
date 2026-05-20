part of 'staff_form_bottom_sheet.dart';

extension StaffFormBottomSheetStateFields1 on _StaffFormBottomSheetState {
  List<Widget> _buildStaffFormBottomSheetFields1(BuildContext context) {
    return [
                Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: context.color.border,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
                SizedBox(height: 18.h),
                TextApp(
                  text: _isEditing
                      ? context.translate(LangKeys.editStaff)
                      : context.translate(LangKeys.addStaffMember),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _name,
                  label: context.translate(LangKeys.fullName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.fullName),
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _email,
                  label: context.translate(LangKeys.email),
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.requiredEmail(
                    context,
                    fieldName: context.translate(LangKeys.email),
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _phone,
                  label: context.translate(LangKeys.phone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 12.h),
                AppDropdownField<String>(
                  value: _role,
                  label: context.translate(LangKeys.role),
                  isRequired: true,
                  items: staffRoles.map((role) {
                    return AppDropdownItem<String>(
                      value: role,
                      label: formatStaffRole(context, role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _role = value ?? _role;
                    });
                  },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.role),
                  ),
                ),
                SizedBox(height: 12.h),
    ];
  }
}
