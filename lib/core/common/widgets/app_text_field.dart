import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/context_extension.dart';
import 'text_app.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.label,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.isRequired = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? minLines;
  final bool enabled;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final labelText = isRequired ? '$label *' : label;

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      style: context.textStyle,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorMaxLines: 2,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),
    );
  }
}

class AppTextFieldLabel extends StatelessWidget {
  const AppTextFieldLabel({
    required this.text,
    this.isRequired = false,
    super.key,
  });

  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return TextApp(
      text: isRequired ? '$text *' : text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      theme: context.textStyle,
    );
  }
}
