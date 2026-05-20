part of 'purchase_order_form_bottom_sheet.dart';

class _PurchaseOrderItemFormBottomSheetState
    extends State<_PurchaseOrderItemFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final quantity = TextEditingController(text: '1');
  final unitCost = TextEditingController();

  String? medicationId;

  @override
  void initState() {
    super.initState();

    medicationId = widget.medications.isNotEmpty
        ? widget.medications.first.id
        : null;

    final medication = _selectedMedication;

    if (medication != null) {
      final cost = medication.costPrice ?? medication.price;
      unitCost.text = cost.toStringAsFixed(2);
    }
  }

  MedicationModel? get _selectedMedication {
    if (medicationId == null) return null;

    for (final medication in widget.medications) {
      if (medication.id == medicationId) {
        return medication;
      }
    }

    return null;
  }

  @override
  void dispose() {
    quantity.dispose();
    unitCost.dispose();
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
        color: Colors.white,
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
                  text: context.translate(LangKeys.addItem),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
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
                  onChanged: this._onMedicationChanged,
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
                  controller: unitCost,
                  label: context.translate(LangKeys.unitCost),
                  isRequired: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: AppValidators.requiredPositiveNumber(
                    context,
                    fieldName: context.translate(LangKeys.unitCost),
                  ),
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
