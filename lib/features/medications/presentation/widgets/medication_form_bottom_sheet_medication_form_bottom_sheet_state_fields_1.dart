part of 'medication_form_bottom_sheet.dart';

extension MedicationFormBottomSheetStateFields1 on _MedicationFormBottomSheetState {
  List<Widget> _buildMedicationFormBottomSheetFields1(BuildContext context) {
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
                      ? context.translate(LangKeys.editMedication)
                      : context.translate(LangKeys.addMedication),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: _formController.nameController,
                  label: context.translate(LangKeys.name),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.name),
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _formController.genericNameController,
                  label: context.translate(LangKeys.genericName),
                ),
                SizedBox(height: 12.h),
                AppDropdownField<String>(
                  value: _formController.category,
                  label: context.translate(LangKeys.category),
                  items: medicationCategories.map((category) {
                    return AppDropdownItem<String>(
                      value: category,
                      label: medicationCategoryLabel(context, category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _formController.category = value;
                    });
                  },
                ),
                SizedBox(height: 12.h),
                AppDropdownField<String>(
                  value: _formController.dosageForm,
                  label: context.translate(LangKeys.dosageForm),
                  items: medicationForms.map((form) {
                    return AppDropdownItem<String>(
                      value: form,
                      label: medicationFormLabel(context, form),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _formController.dosageForm = value;
                    });
                  },
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _formController.strengthController,
                  label: context.translate(LangKeys.strength),
                  hintText: context.translate(LangKeys.strengthHint),
                ),
                SizedBox(height: 12.h),
    ];
  }
}
