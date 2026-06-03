part of 'staff_form_bottom_sheet.dart';

extension StaffFormBottomSheetStateFields2 on _StaffFormBottomSheetState {
  List<Widget> _buildStaffFormBottomSheetFields2(BuildContext context) {
    final activeBranches = _activeBranches;

    return [
                AppDropdownField<String>(
                  value: _branchId,
                  label: context.translate(LangKeys.branch),
                  isRequired: true,
                  items: activeBranches.map((branch) {
                    return AppDropdownItem<String>(
                      value: branch.id,
                      label: branch.name,
                    );
                  }).toList(),
                  onChanged: activeBranches.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            _branchId = value;
                          });
                        },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
                if (activeBranches.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(LangKeys.noActiveBranchesFound),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(color: Colors.red),
                    ),
                  ),
                ],
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _license,
                  label: context.translate(LangKeys.licenseNumber),
                ),
                SizedBox(height: 12.h),
                AppDateField(
                  controller: _hireDate,
                  label: context.translate(LangKeys.hireDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 8.h),
                AppSwitchField(
                  value: _active,
                  title: context.translate(LangKeys.active),
                  onChanged: (value) {
                    setState(() {
                      _active = value;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveStaff),
                  onPressed: _isSaving ? null : this._save,
                  isLoading: _isSaving,
                ),
    ];
  }
}
