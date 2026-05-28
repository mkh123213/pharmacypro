import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';
import '../language/lang_keys.dart';

class AppValidators {
  const AppValidators._();

  static FormFieldValidator<String> required(
    BuildContext context, {
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        if (fieldName == null || fieldName.trim().isEmpty) {
          return context.translate(LangKeys.fieldRequired);
        }

        return context
            .translate(LangKeys.fieldIsRequired)
            .replaceAll('{field}', fieldName);
      }

      return null;
    };
  }

  static FormFieldValidator<T> requiredDropdown<T>(
    BuildContext context, {
    required String fieldName,
  }) {
    return (value) {
      if (value == null || value.toString().trim().isEmpty) {
        return context
            .translate(LangKeys.fieldIsRequired)
            .replaceAll('{field}', fieldName);
      }

      return null;
    };
  }

  static FormFieldValidator<String> optionalEmail(BuildContext context) {
    return (value) {
      final text = value?.trim() ?? '';

      if (text.isEmpty) return null;

      final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');

      if (!emailRegex.hasMatch(text)) {
        return context.translate(LangKeys.invalidEmail);
      }

      return null;
    };
  }

  static FormFieldValidator<String> requiredEmail(
    BuildContext context, {
    String? fieldName,
  }) {
    return (value) {
      final requiredError = required(
        context,
        fieldName: fieldName ?? context.translate(LangKeys.email),
      )(value);

      if (requiredError != null) return requiredError;

      return optionalEmail(context)(value);
    };
  }

  static FormFieldValidator<String> optionalPhone(BuildContext context) {
    return (value) {
      final text = value?.trim() ?? '';

      if (text.isEmpty) return null;

      final phoneRegex = RegExp(r'^\+?[0-9\s\-()]{7,20}$');

      if (!phoneRegex.hasMatch(text)) {
        return context.translate(LangKeys.invalidPhone);
      }

      return null;
    };
  }

  static FormFieldValidator<String> requiredPhone(
    BuildContext context, {
    String? fieldName,
  }) {
    return (value) {
      final requiredError = required(
        context,
        fieldName: fieldName ?? context.translate(LangKeys.phone),
      )(value);

      if (requiredError != null) return requiredError;

      return optionalPhone(context)(value);
    };
  }

  static FormFieldValidator<String> requiredNumber(
    BuildContext context, {
    String? fieldName,
  }) {
    return (value) {
      final requiredError = required(context, fieldName: fieldName)(value);

      if (requiredError != null) return requiredError;

      final number = num.tryParse(value!.trim());

      if (number == null) {
        return context.translate(LangKeys.enterValidNumber);
      }

      return null;
    };
  }

  static FormFieldValidator<String> optionalNumber(BuildContext context) {
    return (value) {
      final text = value?.trim() ?? '';

      if (text.isEmpty) return null;

      final number = num.tryParse(text);

      if (number == null) {
        return context.translate(LangKeys.enterValidNumber);
      }

      return null;
    };
  }

  static FormFieldValidator<String> requiredPositiveNumber(
    BuildContext context, {
    String? fieldName,
  }) {
    return (value) {
      final numberError = requiredNumber(context, fieldName: fieldName)(value);

      if (numberError != null) return numberError;

      final number = num.parse(value!.trim());

      if (number <= 0) {
        return context.translate(LangKeys.numberMustBePositive);
      }

      return null;
    };
  }

  static FormFieldValidator<String> optionalPositiveNumber(
    BuildContext context,
  ) {
    return (value) {
      final text = value?.trim() ?? '';

      if (text.isEmpty) return null;

      final number = num.tryParse(text);

      if (number == null) {
        return context.translate(LangKeys.enterValidNumber);
      }

      if (number <= 0) {
        return context.translate(LangKeys.numberMustBePositive);
      }

      return null;
    };
  }

  static FormFieldValidator<String> requiredNonNegativeNumber(
    BuildContext context, {
    String? fieldName,
  }) {
    return (value) {
      final numberError = requiredNumber(context, fieldName: fieldName)(value);

      if (numberError != null) return numberError;

      final number = num.parse(value!.trim());

      if (number < 0) {
        return context.translate(LangKeys.numberCannotBeNegative);
      }

      return null;
    };
  }

  static FormFieldValidator<String> optionalNonNegativeNumber(
    BuildContext context,
  ) {
    return (value) {
      final text = value?.trim() ?? '';

      if (text.isEmpty) return null;

      final number = num.tryParse(text);

      if (number == null) {
        return context.translate(LangKeys.enterValidNumber);
      }

      if (number < 0) {
        return context.translate(LangKeys.numberCannotBeNegative);
      }

      return null;
    };
  }

  static FormFieldValidator<String> optionalDate(BuildContext context) {
    return (value) {
      final text = value?.trim() ?? '';

      if (text.isEmpty) return null;

      final date = DateTime.tryParse(text);

      if (date == null) {
        return context.translate(LangKeys.invalidDate);
      }

      return null;
    };
  }

  static FormFieldValidator<String> requiredDate(
    BuildContext context, {
    String? fieldName,
  }) {
    return (value) {
      final requiredError = required(context, fieldName: fieldName)(value);

      if (requiredError != null) return requiredError;

      return optionalDate(context)(value);
    };
  }

  static FormFieldValidator<String> optionalTime(BuildContext context) {
    return (value) {
      final text = value?.trim() ?? '';

      if (text.isEmpty) return null;

      final timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

      if (!timeRegex.hasMatch(text)) {
        return context.translate(LangKeys.invalidTime);
      }

      return null;
    };
  }

  static FormFieldValidator<String> requiredTime(
    BuildContext context, {
    String? fieldName,
  }) {
    return (value) {
      final requiredError = required(context, fieldName: fieldName)(value);

      if (requiredError != null) return requiredError;

      return optionalTime(context)(value);
    };
  }

  static FormFieldValidator<String> optionalUrl(BuildContext context) {
    return (value) {
      final text = value?.trim() ?? '';

      if (text.isEmpty) return null;

      final uri = Uri.tryParse(text);

      if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
        return context.translate(LangKeys.invalidUrl);
      }

      return null;
    };
  }

  static String? endDateAfterStartDate(
    BuildContext context, {
    required String? startDate,
    required String? endDate,
  }) {
    final startText = startDate?.trim() ?? '';
    final endText = endDate?.trim() ?? '';

    if (startText.isEmpty || endText.isEmpty) return null;

    final start = DateTime.tryParse(startText);
    final end = DateTime.tryParse(endText);

    if (start == null || end == null) return null;

    if (end.isBefore(start)) {
      return context.translate(LangKeys.endDateMustBeAfterStartDate);
    }

    return null;
  }

  static String? endTimeAfterStartTime(
    BuildContext context, {
    required String? startTime,
    required String? endTime,
  }) {
    final startText = startTime?.trim() ?? '';
    final endText = endTime?.trim() ?? '';

    if (startText.isEmpty || endText.isEmpty) return null;

    final startMinutes = _timeToMinutes(startText);
    final endMinutes = _timeToMinutes(endText);

    if (startMinutes == null || endMinutes == null) return null;

    if (endMinutes <= startMinutes) {
      return context.translate(LangKeys.endTimeMustBeAfterStartTime);
    }

    return null;
  }

  static int? _timeToMinutes(String value) {
    final parts = value.split(':');

    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23) return null;
    if (minute < 0 || minute > 59) return null;

    return hour * 60 + minute;
  }
}
