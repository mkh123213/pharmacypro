import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app_cubit/app_cubit.dart';
import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';

class AppThemeToggleButton extends StatelessWidget {
  const AppThemeToggleButton({this.inverted = false, super.key});

  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final cubit = context.read<AppCubit>();
        final labelKey = cubit.isDark ? LangKeys.lightMode : LangKeys.darkMode;
        final icon = cubit.isDark
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined;
        final color = inverted ? Colors.white : context.color.textPrimary;

        return IconButton(
          tooltip: context.translate(labelKey),
          onPressed: () => cubit.changeAppThemeMode(),
          icon: Icon(icon, color: color),
        );
      },
    );
  }
}
