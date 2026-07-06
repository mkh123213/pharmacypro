import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacypro/core/common/widgets/app_image_asset_previewer.dart';

import '../../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../app/app_cubit/app_cubit.dart';
import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import 'text_app.dart';

class AppSidebarControls extends StatelessWidget {
  const AppSidebarControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final cubit = context.read<AppCubit>();
        final authCubit = context.read<AuthCubit>();
        final colors = context.color;
        final langLabel = cubit.currentLangCode == 'ar' ? 'EN' : 'AR';
        final themeLabel = cubit.isDark
            ? context.translate(LangKeys.lightMode)
            : context.translate(LangKeys.darkMode);

        final userName = authCubit.currentUser?.fullName ?? '';

        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
          child: Column(
            children: [
              if (userName.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: colors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: TextApp(
                          text: userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          theme: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: _SidebarControlButton(
                      imagePath: context.assets.themeMode,

                      label: themeLabel,
                      onPressed: () => cubit.changeAppThemeMode(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SidebarControlButton(
                      imagePath: context.assets.language,
                      label: langLabel,
                      onPressed: () => cubit.toggleLanguage(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: _SidebarControlButton(
                  imagePath: context.assets.logOut,
                  label: context.translate(LangKeys.logout),
                  onPressed: () => authCubit.signOut(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SidebarControlButton extends StatelessWidget {
  const _SidebarControlButton({
    required this.label,
    required this.imagePath,
    required this.onPressed,
  });

  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;

    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.textPrimary,
        side: BorderSide(color: colors.border),
        backgroundColor: colors.surface,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      ),
      icon: FittedBox(
        fit: BoxFit.scaleDown,
        child: AppImageAssetPreviewer(imagePath, width: 20, height: 20),
      ),
      label: TextApp(
        text: label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        theme: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
