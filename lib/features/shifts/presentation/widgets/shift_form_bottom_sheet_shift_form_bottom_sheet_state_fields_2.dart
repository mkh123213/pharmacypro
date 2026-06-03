part of 'shift_form_bottom_sheet.dart';

extension ShiftFormBottomSheetStateFields2 on _ShiftFormBottomSheetState {
  List<Widget> _buildShiftFormBottomSheetFields2(BuildContext context) {
    return [
                if (widget.branches.isEmpty) ...[
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
                SizedBox(height: 10.h),
                AppDateField(
                  controller: date,
                  label: context.translate(LangKeys.date),
                  isRequired: true,
                  validator: AppValidators.requiredDate(
                    context,
                    fieldName: context.translate(LangKeys.date),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTimeField(
                  controller: start,
                  label: context.translate(LangKeys.startTime),
                  isRequired: true,
                  validator: AppValidators.requiredTime(
                    context,
                    fieldName: context.translate(LangKeys.startTime),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTimeField(
                  controller: end,
                  label: context.translate(LangKeys.endTime),
                  isRequired: true,
                  validator: AppValidators.requiredTime(
                    context,
                    fieldName: context.translate(LangKeys.endTime),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: notes,
                  label: context.translate(LangKeys.notes),
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.scheduleShift),
                  onPressed: _isSaving ? null : this.save,
                  isLoading: _isSaving,
                ),
    ];
  }
}
