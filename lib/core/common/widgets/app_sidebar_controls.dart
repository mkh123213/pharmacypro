import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      const Icon(
                        Icons.person_outline,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: TextApp(
                          text: userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          theme: const TextStyle(
                            color: Colors.white70,
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
                      icon: cubit.isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      label: themeLabel,
                      onPressed: () => cubit.changeAppThemeMode(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SidebarControlButton(
                      icon: Icons.language_outlined,
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
                  icon: Icons.logout_outlined,
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
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withOpacity(0.16)),
        backgroundColor: Colors.white.withOpacity(0.06),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      ),
      icon: Icon(icon, size: 17),
      label: TextApp(
        text: label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        theme: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
