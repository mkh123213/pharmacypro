import 'package:intl/intl.dart';

extension StringFormate on String {
  String imageProductFormate() {
    return replaceAll(RegExp(r'^\["?|"\]?|"$'), '');
  }

  String toCapitalized() {
    if (trim().isEmpty) return this;

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String convertLongString() {
    final parts = split(' ');

    if (parts.length <= 2) return this;

    return parts.sublist(0, parts.length - 2).join(' ');
  }

  String convertDataFormate() {
    final parsedDate = DateTime.tryParse(this);

    return DateFormat('d MMM, y - h:mm a').format(parsedDate ?? DateTime.now());
  }
}
