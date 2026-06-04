import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../extensions/context_extension.dart';
import '../../routing/app_routes.dart';
import 'app_language_toggle_button.dart';
import 'app_theme_toggle_button.dart';
import 'smart_barcode_scanner.dart';

class AppTopBarActions extends StatelessWidget {
  const AppTopBarActions({required this.showAvatar, super.key});

  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;
    final user = context.read<AuthCubit>().currentUser;
    final userName = user?.fullName ?? '';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SmartBarcodeScannerButton(),
        IconButton(
          onPressed: () => context.push(AppRoutes.inventoryAlerts),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: colors.textPrimary,
          ),
        ),
        const AppThemeToggleButton(),
        SizedBox(width: 4.w),
        const AppLanguageToggleButton(),
        if (showAvatar) ...[
          SizedBox(width: 10.w),
          Tooltip(
            message: userName,
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: colors.primary.withOpacity(0.12),
              child: Icon(
                Icons.person_outline,
                color: colors.primary,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
