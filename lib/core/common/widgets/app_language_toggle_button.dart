import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_cubit/app_cubit.dart';
import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import 'text_app.dart';

class AppLanguageToggleButton extends StatelessWidget {
  const AppLanguageToggleButton({this.inverted = false, super.key});

  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final cubit = context.read<AppCubit>();
        final switchToArabic = cubit.currentLangCode != 'ar';
        final label = switchToArabic ? 'AR' : 'EN';
        final tooltip = switchToArabic
            ? context.translate(LangKeys.switchToArabic)
            : context.translate(LangKeys.switchToEnglish);
        final foreground = inverted ? Colors.white : context.color.primary;
        final background = inverted
            ? Colors.white.withOpacity(0.08)
            : context.color.primary.withOpacity(0.08);

        return Tooltip(
          message: tooltip,
          child: TextButton.icon(
            onPressed: () => cubit.toggleLanguage(),
            style: TextButton.styleFrom(
              minimumSize: Size(62.w, 38.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              foregroundColor: foreground,
              backgroundColor: background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
            icon: Icon(Icons.language_outlined, size: 18.sp),
            label: TextApp(
              text: label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: TextStyle(fontWeight: FontWeight.w800, color: foreground),
            ),
          ),
        );
      },
    );
  }
}
