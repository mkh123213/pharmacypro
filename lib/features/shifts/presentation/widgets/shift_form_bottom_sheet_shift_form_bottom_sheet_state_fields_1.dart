part of 'shift_form_bottom_sheet.dart';

extension ShiftFormBottomSheetStateFields1 on _ShiftFormBottomSheetState {
  List<Widget> _buildShiftFormBottomSheetFields1(BuildContext context) {
    return [
                AppBottomSheetHeader(
                  title: context.translate(LangKeys.addShift),
                ),
                SizedBox(height: 16.h),
                AppDropdownField<String>(
                  value: staffId,
                  label: context.translate(LangKeys.staffMember),
                  isRequired: true,
                  items: widget.staff.map((member) {
                    return AppDropdownItem<String>(
                      value: member.id,
                      label: '${member.fullName} - ${member.role}',
                    );
                  }).toList(),
                  onChanged: widget.staff.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            staffId = value;
                          });
                        },
                  validator: AppValidators.requiredDropdown<String>(
                    context,
                    fieldName: context.translate(LangKeys.staffMember),
                  ),
                ),
                if (widget.staff.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(LangKeys.noActiveStaffFound),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(color: Colors.red),
                    ),
                  ),
                ],
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
                  onChanged: widget.branches.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            branchId = value;
                          });
                        },
                  validator: AppValidators.requiredDropdown<String>(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
    ];
  }
}
