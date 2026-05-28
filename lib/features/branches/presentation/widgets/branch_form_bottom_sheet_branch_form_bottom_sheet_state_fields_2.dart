part of 'branch_form_bottom_sheet.dart';

extension BranchFormBottomSheetStateFields2 on _BranchFormBottomSheetState {
  List<Widget> _buildBranchFormBottomSheetFields2(BuildContext context) {
    return [
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
                  text: context.translate(LangKeys.saveBranch),
                  onPressed: _isSaving ? null : this._save,
                  isLoading: _isSaving,
                ),
    ];
  }
}
