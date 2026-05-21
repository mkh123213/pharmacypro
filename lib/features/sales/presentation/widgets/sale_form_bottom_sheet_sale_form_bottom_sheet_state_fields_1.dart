part of 'sale_form_bottom_sheet.dart';

extension SaleFormBottomSheetStateFields1 on _SaleFormBottomSheetState {
  List<Widget> _buildSaleFormBottomSheetFields1(BuildContext context) {
    final availableBranches = activeBranches;

    return [
                AppBottomSheetHeader(
                  title: context.translate(LangKeys.newSale),
                ),
                SizedBox(height: 16.h),
                if (availableBranches.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: TextApp(
                      text: context.translate(LangKeys.noActiveBranchesFound),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  AppDropdownField<String>(
                    value: branchId,
                    label: context.translate(LangKeys.branch),
                    isRequired: true,
                    items: availableBranches.map((branch) {
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
                SizedBox(height: 10.h),
                AppDropdownField<String>(
                  value: payment,
                  label: context.translate(LangKeys.paymentMethod),
                  items: paymentMethods.map((method) {
                    return AppDropdownItem<String>(
                      value: method,
                      label: paymentMethodLabel(context, method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      payment = value ?? payment;
                    });
                  },
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: customer,
                  label: context.translate(LangKeys.customerName),
                ),
                SizedBox(height: 10.h),
    ];
  }
}
