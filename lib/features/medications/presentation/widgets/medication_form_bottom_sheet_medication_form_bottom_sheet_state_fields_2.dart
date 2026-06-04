part of 'medication_form_bottom_sheet.dart';

extension MedicationFormBottomSheetStateFields2 on _MedicationFormBottomSheetState {
  List<Widget> _buildMedicationFormBottomSheetFields2(BuildContext context) {
    return [
                AppTextField(
                  controller: _formController.manufacturerController,
                  label: context.translate(LangKeys.manufacturer),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _formController.priceController,
                  label: context.translate(LangKeys.price),
                  isRequired: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: AppValidators.requiredNonNegativeNumber(
                    context,
                    fieldName: context.translate(LangKeys.price),
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _formController.costPriceController,
                  label: context.translate(LangKeys.costPrice),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: AppValidators.optionalNonNegativeNumber(context),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _formController.barcodeController,
                        label: context.translate(LangKeys.barcode),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    MedicationBarcodeScannerButton(
                      onScan: (code) {
                        setState(() {
                          _formController.barcodeController.text = code;
                        });

                        ShowToast.showToastSuccessTop(
                          message: context.translate(
                            LangKeys.barcodeScannedSuccessfully,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _formController.descriptionController,
                  label: context.translate(LangKeys.description),
                  maxLines: 3,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _formController.imageUrlController,
                  label: context.translate(LangKeys.imageUrl),
                  keyboardType: TextInputType.url,
                  validator: AppValidators.optionalUrl(context),
                ),
                SizedBox(height: 12.h),
    ];
  }
}
