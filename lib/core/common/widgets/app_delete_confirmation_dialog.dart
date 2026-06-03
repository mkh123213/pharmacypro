import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import 'text_app.dart';

Future<bool?> showDeleteConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
}) {
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: TextApp(
          text: title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          theme: dialogContext.textStyle.copyWith(fontWeight: FontWeight.w700),
        ),
        content: TextApp(
          text: message,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          theme: dialogContext.textStyle,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: TextApp(
              text: dialogContext.translate(LangKeys.cancel),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: dialogContext.textStyle,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: TextApp(
              text: dialogContext.translate(LangKeys.yesDelete),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: dialogContext.textStyle.copyWith(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
