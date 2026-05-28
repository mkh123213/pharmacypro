import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/context_extension.dart';
import 'text_app.dart';

class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
    this.validator,
    this.enabled = true,
    this.isRequired = false,
    super.key,
  });

  final T? value;
  final String label;
  final List<AppDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final bool enabled;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final labelText = isRequired ? '$label *' : label;

    return DropdownButtonFormField<T>(
      initialValue: value,
      validator: validator,
      onChanged: enabled ? onChanged : null,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: labelText,
        errorMaxLines: 2,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item.value,
          child: TextApp(
            text: item.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        );
      }).toList(),
    );
  }
}

class AppDropdownItem<T> {
  const AppDropdownItem({required this.value, required this.label});

  final T value;
  final String label;
}
