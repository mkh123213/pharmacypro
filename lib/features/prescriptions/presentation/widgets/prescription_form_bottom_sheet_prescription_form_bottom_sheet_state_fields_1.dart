part of 'prescription_form_bottom_sheet.dart';

extension PrescriptionFormBottomSheetStateFields1 on _PrescriptionFormBottomSheetState {
  List<Widget> _buildPrescriptionFormBottomSheetFields1(BuildContext context) {
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
                  text: context.translate(LangKeys.newPrescription),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: patient,
                  label: context.translate(LangKeys.patientName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.patientName),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: phone,
                  label: context.translate(LangKeys.patientPhone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: doctor,
                  label: context.translate(LangKeys.doctorName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.doctorName),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: license,
                  label: context.translate(LangKeys.doctorLicense),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: issueDate,
                  label: context.translate(LangKeys.issueDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: expiryDate,
                  label: context.translate(LangKeys.expiryDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 10.h),
    ];
  }
}
