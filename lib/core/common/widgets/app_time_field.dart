import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import 'app_text_field.dart';

class AppTimeField extends StatelessWidget {
  const AppTimeField({
    required this.controller,
    required this.label,
    this.validator,
    this.isRequired = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hintText: 'HH:mm',
      readOnly: true,
      isRequired: isRequired,
      validator: validator,
      suffixIcon: const Icon(Icons.access_time_outlined),
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: _parseTime(controller.text.trim()) ?? TimeOfDay.now(),
          helpText: context.translate(LangKeys.selectTime),
        );

        if (picked == null) return;

        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');

        controller.text = '$hour:$minute';
      },
    );
  }

  TimeOfDay? _parseTime(String value) {
    final parts = value.split(':');

    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23) return null;
    if (minute < 0 || minute > 59) return null;

    return TimeOfDay(hour: hour, minute: minute);
  }
}
