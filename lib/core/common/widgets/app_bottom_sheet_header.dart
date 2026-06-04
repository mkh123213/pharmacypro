import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import 'text_app.dart';

class AppBottomSheetHeader extends StatelessWidget {
  const AppBottomSheetHeader({
    required this.title,
    this.subtitle,
    this.trailing,
    this.onBack,
    this.showHandle = true,
    super.key,
  });
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onBack;
  final bool showHandle;
  @override
  Widget build(BuildContext context) {
    final colors = context.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHandle) ...[
          Center(
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
          ),
          SizedBox(height: 14.h),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BottomSheetBackButton(onBack: onBack),
            SizedBox(width: 10.w),
            Expanded(
              child: _BottomSheetTitle(title: title, subtitle: subtitle),
            ),
            if (trailing != null) ...[SizedBox(width: 10.w), trailing!],
          ],
        ),
      ],
    );
  }
}

class _BottomSheetBackButton extends StatelessWidget {
  const _BottomSheetBackButton({this.onBack});
  final VoidCallback? onBack;
  @override
  Widget build(BuildContext context) {
    final colors = context.color;

    return Tooltip(
      message: context.translate(LangKeys.back),
      child: Material(
        color: colors.surface,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap:
              onBack ??
              () {
                Navigator.of(context).maybePop();
              },
          child: SizedBox(
            width: 36.w,
            height: 36.w,
            child: Icon(
              Icons.arrow_back_rounded,
              color: colors.textPrimary,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomSheetTitle extends StatelessWidget {
  const _BottomSheetTitle({required this.title, this.subtitle});
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextApp(
          text: title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
        ),
        if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
          SizedBox(height: 4.h),
          TextApp(
            text: subtitle!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle.copyWith(
              color: context.color.textSecondary,
              fontSize: 12.sp,
            ),
          ),
        ],
      ],
    );
  }
}
