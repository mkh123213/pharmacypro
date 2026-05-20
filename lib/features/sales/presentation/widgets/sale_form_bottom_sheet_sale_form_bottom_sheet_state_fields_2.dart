part of 'sale_form_bottom_sheet.dart';

extension SaleFormBottomSheetStateFields2 on _SaleFormBottomSheetState {
  List<Widget> _buildSaleFormBottomSheetFields2(BuildContext context) {
    return [
                AppTextField(
                  controller: phone,
                  label: context.translate(LangKeys.customerPhone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: activeMedications.isEmpty ? null : this.addItem,
                    icon: const Icon(Icons.add),
                    label: TextApp(
                      text: context.translate(LangKeys.addItem),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ),
                ),
                if (activeMedications.isEmpty) ...[
                  SizedBox(height: 6.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextApp(
                      text: context.translate(
                        LangKeys.noActiveMedicationsFound,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 8.h),
    ];
  }
}
