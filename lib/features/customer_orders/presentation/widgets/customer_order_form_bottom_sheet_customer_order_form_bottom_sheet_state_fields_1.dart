part of 'customer_order_form_bottom_sheet.dart';

extension CustomerOrderFormBottomSheetStateFields1 on _CustomerOrderFormBottomSheetState {
  List<Widget> _buildCustomerOrderFormBottomSheetFields1(BuildContext context) {
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
                  text: context.translate(LangKeys.newOrder),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: name,
                  label: context.translate(LangKeys.customerName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.customerName),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: phone,
                  label: context.translate(LangKeys.customerPhone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 10.h),
                AppDropdownField<String>(
                  value: orderType,
                  label: context.translate(LangKeys.orderType),
                  items: customerOrderTypes.map((type) {
                    return AppDropdownItem<String>(
                      value: type,
                      label: customerOrderTypeLabel(context, type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      orderType = value ?? orderType;
                    });
                  },
                ),
                if (orderType == 'delivery') ...[
                  SizedBox(height: 10.h),
                  AppTextField(
                    controller: address,
                    label: context.translate(LangKeys.deliveryAddress),
                    isRequired: true,
                    maxLines: 2,
                    validator: AppValidators.required(
                      context,
                      fieldName: context.translate(LangKeys.deliveryAddress),
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
    ];
  }
}
