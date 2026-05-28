part of 'prescription_form_bottom_sheet.dart';

extension PrescriptionFormBottomSheetStateFields2 on _PrescriptionFormBottomSheetState {
  List<Widget> _buildPrescriptionFormBottomSheetFields2(BuildContext context) {
    return [
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
                  onChanged: (value) {
                    setState(() {
                      branchId = value;
                    });
                  },
                  validator: AppValidators.requiredDropdown<String>(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
                SizedBox(height: 14.h),
                _PrescriptionItemsSection(
                  items: items,
                  onAddPressed: this._addPrescriptionItem,
                  onRemovePressed: this._removePrescriptionItem,
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: notes,
                  label: context.translate(LangKeys.notes),
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.createPrescription),
                  onPressed: _isSaving ? null : this.save,
                  isLoading: _isSaving,
                ),
    ];
  }
}
