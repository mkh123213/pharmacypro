import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import 'app_text_field.dart';

class AppDateField extends StatelessWidget {
  const AppDateField({
    required this.controller,
    required this.label,
    this.validator,
    this.firstDate,
    this.lastDate,
    this.isRequired = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hintText: 'yyyy-MM-dd',
      readOnly: true,
      isRequired: isRequired,
      validator: validator,
      suffixIcon: const Icon(Icons.calendar_today_outlined),
      onTap: () async {
        final now = DateTime.now();

        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.tryParse(controller.text.trim()) ?? now,
          firstDate: firstDate ?? DateTime(now.year - 10),
          lastDate: lastDate ?? DateTime(now.year + 10),
          helpText: context.translate(LangKeys.selectDate),
        );

        if (picked == null) return;

        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      },
    );
  }
}
