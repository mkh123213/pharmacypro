import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/medications/data/models/medication_model.dart';
import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import '../../utils/app_validators.dart';
import 'app_primary_button.dart';
import 'app_text_field.dart';
import 'sale_medication_picker_list.dart';
import 'text_app.dart';

class SaleMedicationPickerContent extends StatelessWidget {
  const SaleMedicationPickerContent({
    required this.formKey,
    required this.medications,
    required this.selectedMedication,
    required this.searchController,
    required this.quantityController,
    required this.onSearchChanged,
    required this.onMedicationSelected,
    required this.onSubmit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final List<MedicationModel> medications;
  final MedicationModel? selectedMedication;
  final TextEditingController searchController;
  final TextEditingController quantityController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<MedicationModel> onMedicationSelected;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: context.color.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Form(
          key: formKey,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * .78,
            child: Column(
              children: [
                _DragHandle(),
                SizedBox(height: 18.h),
                TextApp(
                  text: context.translate(LangKeys.selectMedication),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: searchController,
                  label: context.translate(LangKeys.searchMedication),
                  prefixIcon: const Icon(Icons.search),
                  onChanged: onSearchChanged,
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: SaleMedicationPickerList(
                    medications: medications,
                    selectedMedication: selectedMedication,
                    onMedicationSelected: onMedicationSelected,
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: quantityController,
                  label: context.translate(LangKeys.quantity),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  validator: AppValidators.requiredPositiveNumber(
                    context,
                    fieldName: context.translate(LangKeys.quantity),
                  ),
                ),
                SizedBox(height: 12.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.addItem),
                  onPressed: onSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: context.color.border,
        borderRadius: BorderRadius.circular(999.r),
      ),
    );
  }
}
