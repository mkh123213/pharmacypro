import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/context_extension.dart';
import 'text_app.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 34.w,
              height: 34.w,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: colors.primary,
              ),
            ),
            if (message != null) ...[
              SizedBox(height: 14.h),
              TextApp(
                text: message!,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
