import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';
import 'app_top_bar_actions.dart';
import 'text_app.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({this.showMenuButton = false, super.key});

  final bool showMenuButton;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: colors.background,
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 380;

            return Row(
              children: [
                if (showMenuButton)
                  IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Icon(Icons.menu, color: colors.textPrimary),
                  ),
                if (!showMenuButton) const SizedBox(width: 8),
                Expanded(
                  child: TextApp(
                    text: 'PharmaChain',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AppTopBarActions(showAvatar: !compact),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
