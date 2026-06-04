import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';
import 'text_app.dart';

class AppSwitchField extends StatelessWidget {
  const AppSwitchField({
    required this.value,
    required this.title,
    required this.onChanged,
    this.subtitle,
    this.enabled = true,
    super.key,
  });

  final bool value;
  final String title;
  final String? subtitle;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      contentPadding: EdgeInsets.zero,
      onChanged: enabled ? onChanged : null,
      title: TextApp(
        text: title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        theme: context.textStyle,
      ),
      subtitle: subtitle == null
          ? null
          : TextApp(
              text: subtitle!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
    );
  }
}
