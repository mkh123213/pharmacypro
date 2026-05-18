import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/features/medications/data/models/medication_model.dart';

import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';

class SaleMedicationPickerResult {
  const SaleMedicationPickerResult({
    required this.medication,
    required this.quantity,
  });

  final MedicationModel medication;
  final int quantity;
}

Future<SaleMedicationPickerResult?> showSaleMedicationPickerBottomSheet({
  required BuildContext context,
  required List<MedicationModel> medications,
}) {
  return showModalBottomSheet<SaleMedicationPickerResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return SaleMedicationPickerBottomSheet(medications: medications);
    },
  );
}

class SaleMedicationPickerBottomSheet extends StatefulWidget {
  const SaleMedicationPickerBottomSheet({required this.medications, super.key});

  final List<MedicationModel> medications;

  @override
  State<SaleMedicationPickerBottomSheet> createState() =>
      _SaleMedicationPickerBottomSheetState();
}

class _SaleMedicationPickerBottomSheetState
    extends State<SaleMedicationPickerBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');

  MedicationModel? _selectedMedication;
  String _searchQuery = '';

  List<MedicationModel> get _filteredMedications {
    final query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) return widget.medications;

    return widget.medications.where((medication) {
      return medication.name.toLowerCase().contains(query) ||
          (medication.genericName?.toLowerCase().contains(query) ?? false) ||
          (medication.barcode?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedMedication == null) return;

    Navigator.pop(
      context,
      SaleMedicationPickerResult(
        medication: _selectedMedication!,
        quantity: int.tryParse(_quantityController.text.trim()) ?? 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final medications = _filteredMedications;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * .78,
            child: Column(
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
                  text: context.translate(LangKeys.selectMedication),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _searchController,
                  label: context.translate(LangKeys.searchMedication),
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: medications.isEmpty
                      ? Center(
                          child: TextApp(
                            text: context.translate(
                              LangKeys.noMedicationsFound,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle,
                          ),
                        )
                      : ListView.separated(
                          itemCount: medications.length,
                          separatorBuilder: (_, _) => SizedBox(height: 8.h),
                          itemBuilder: (context, index) {
                            final medication = medications[index];
                            final selected =
                                medication.id == _selectedMedication?.id;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedMedication = medication;
                                });
                              },
                              borderRadius: BorderRadius.circular(14.r),
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color: selected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.grey.shade300,
                                  ),
                                  color: selected
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(.06)
                                      : Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.medication_outlined,
                                        size: 20.sp,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextApp(
                                            text: medication.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            theme: context.textStyle,
                                          ),
                                          if ((medication.genericName ?? '')
                                              .isNotEmpty)
                                            TextApp(
                                              text: medication.genericName!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              theme: context.textStyle,
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    TextApp(
                                      text:
                                          '\$${medication.price.toStringAsFixed(2)}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      theme: context.textStyle,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _quantityController,
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
                  onPressed: _selectedMedication == null ? null : _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
