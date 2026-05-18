import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import 'text_app.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({this.showMenuButton = false, super.key});

  final bool showMenuButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: MyColors.background,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (showMenuButton)
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            if (!showMenuButton) SizedBox(width: 8.w),
            Expanded(
              child: TextApp(
                text: 'PharmaChain',
                theme: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: MyColors.textPrimary,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined),
            ),
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 18.r,
              backgroundColor: MyColors.primary.withOpacity(0.12),
              child: Icon(
                Icons.person_outline,
                color: MyColors.primary,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
