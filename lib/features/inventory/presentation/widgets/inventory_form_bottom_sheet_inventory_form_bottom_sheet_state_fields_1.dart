part of 'inventory_form_bottom_sheet.dart';

extension InventoryFormBottomSheetStateFields1 on _InventoryFormBottomSheetState {
  List<Widget> _buildInventoryFormBottomSheetFields1(BuildContext context) {
    final medications = activeMedications;
    final branches = activeBranches;

    return [
                AppBottomSheetHeader(
                  title: _isEditing
                      ? context.translate(LangKeys.editInventoryItem)
                      : context.translate(LangKeys.addInventoryItem),
                ),
                SizedBox(height: 16.h),
                AppDropdownField<String>(
                  value: medicationId,
                  label: context.translate(LangKeys.medication),
                  isRequired: true,
                  items: medications.map((medication) {
                    return AppDropdownItem<String>(
                      value: medication.id,
                      label: medication.name,
                    );
                  }).toList(),
                  onChanged: _isEditing || medications.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            medicationId = value;
                          });
                        },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.medication),
                  ),
                ),
                if (medications.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(
                        LangKeys.noActiveMedicationsFound,
                      ),
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
                  items: branches.map((branch) {
                    return AppDropdownItem<String>(
                      value: branch.id,
                      label: branch.name,
                    );
                  }).toList(),
                  onChanged: _isEditing || branches.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            branchId = value;
                          });
                        },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
    ];
  }
}
