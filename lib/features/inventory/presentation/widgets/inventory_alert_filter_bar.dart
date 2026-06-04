import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../refactor/inventory_alert_filter_values.dart';

part 'inventory_alert_filter_bar_search_field.dart';
part 'inventory_alert_filter_bar_type_dropdown.dart';

class InventoryAlertFilterBar extends StatelessWidget {
  const InventoryAlertFilterBar({
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
                width: 220.w,
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
