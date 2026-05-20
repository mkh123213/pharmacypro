part of 'customer_order_form_bottom_sheet.dart';

extension CustomerOrderFormBottomSheetStateFields2 on _CustomerOrderFormBottomSheetState {
  List<Widget> _buildCustomerOrderFormBottomSheetFields2(BuildContext context) {
    final availableBranches = activeBranches;

    return [
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
                  value: paymentMethod,
                  label: context.translate(LangKeys.paymentMethod),
                  items: customerOrderPaymentMethods.map((method) {
                    return AppDropdownItem<String>(
                      value: method,
                      label: customerOrderPaymentMethodLabel(context, method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value ?? paymentMethod;
                    });
                  },
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: OutlinedButton.icon(
                    onPressed: activeMedications.isEmpty ? null : this.addMedication,
                    icon: const Icon(Icons.add),
                    label: TextApp(
                      text: context.translate(LangKeys.addItem),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ),
                ),
    ];
  }
}
