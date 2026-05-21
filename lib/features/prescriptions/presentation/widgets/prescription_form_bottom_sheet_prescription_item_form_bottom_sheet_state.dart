part of 'prescription_form_bottom_sheet.dart';

class _PrescriptionItemFormBottomSheetState
    extends State<_PrescriptionItemFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final quantity = TextEditingController(text: '1');
  final dosage = TextEditingController();
  final instructions = TextEditingController();

  String? medicationId;

  @override
  void dispose() {
    quantity.dispose();
    dosage.dispose();
    instructions.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: context.color.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBottomSheetHeader(
                  title: context.translate(LangKeys.addPrescriptionItem),
                ),
                SizedBox(height: 16.h),
                AppDropdownField<String>(
                  value: medicationId,
                  label: context.translate(LangKeys.medication),
                  isRequired: true,
                  items: widget.medications.map((medication) {
                    return AppDropdownItem<String>(
                      value: medication.id,
                      label: medication.name,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      medicationId = value;
                    });
                  },
                  validator: AppValidators.requiredDropdown<String>(
                    context,
                    fieldName: context.translate(LangKeys.medication),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: quantity,
                  label: context.translate(LangKeys.quantity),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  validator: AppValidators.requiredPositiveNumber(
                    context,
                    fieldName: context.translate(LangKeys.quantity),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: dosage,
                  label: context.translate(LangKeys.dosage),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: instructions,
                  label: context.translate(LangKeys.instructions),
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.addItem),
                  onPressed: this._saveItem,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
