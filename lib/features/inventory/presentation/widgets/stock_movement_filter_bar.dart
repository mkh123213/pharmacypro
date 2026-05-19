import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';

class StockMovementFilterBar extends StatelessWidget {
  const StockMovementFilterBar({
    required this.selectedType,
    required this.onSearchChanged,
    required this.onTypeChanged,
    super.key,
  });

  final String selectedType;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 700;

        if (wide) {
          return Row(
            children: [
              Expanded(child: _SearchField(onSearchChanged: onSearchChanged)),
              SizedBox(width: 12.w),
              SizedBox(
                width: 240.w,
                child: _TypeDropdown(
                  selectedType: selectedType,
                  onTypeChanged: onTypeChanged,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            _SearchField(onSearchChanged: onSearchChanged),
            SizedBox(height: 12.h),
            _TypeDropdown(
              selectedType: selectedType,
              onTypeChanged: onTypeChanged,
            ),
          ],
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onSearchChanged});

  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: context.translate(LangKeys.searchStockMovements),
      ),
    );
  }
}

class _TypeDropdown extends StatelessWidget {
  const _TypeDropdown({
    required this.selectedType,
    required this.onTypeChanged,
  });

  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return AppDropdownField<String>(
      value: selectedType,
      label: context.translate(LangKeys.movementType),
      items: stockMovementTypes.map((type) {
        return AppDropdownItem<String>(
          value: type,
          label: stockMovementTypeLabel(context, type),
        );
      }).toList(),
      onChanged: (value) {
        onTypeChanged(value ?? 'all');
      },
    );
  }
}

const stockMovementTypes = [
  'all',
  'sale',
  'purchase_received',
  'customer_order_delivered',
  'prescription_dispensed',
  'manual_adjustment',
];

String stockMovementTypeLabel(BuildContext context, String value) {
  switch (value) {
    case 'all':
      return context.translate(LangKeys.allTypes);
    case 'sale':
      return context.translate(LangKeys.sale);
    case 'purchase_received':
      return context.translate(LangKeys.purchaseReceived);
    case 'customer_order_delivered':
      return context.translate(LangKeys.customerOrderDelivered);
    case 'prescription_dispensed':
      return context.translate(LangKeys.prescriptionDispensed);
    case 'manual_adjustment':
      return context.translate(LangKeys.manualAdjustment);
    default:
      return value;
  }
}
