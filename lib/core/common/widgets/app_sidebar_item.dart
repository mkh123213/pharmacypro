import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacypro/core/common/widgets/app_image_asset_previewer.dart';

import '../../extensions/context_extension.dart';
import 'text_app.dart';

class AppSidebarItem extends StatelessWidget {
  const AppSidebarItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.isActive,
    this.imagePath,
    this.badgeCount = 0,
    super.key,
  });

  final IconData icon;

  /// Optional illustration shown instead of [icon] when provided.
  final String? imagePath;
  final String label;
  final String route;
  final bool isActive;
  final int badgeCount;

  Widget _buildLeading(Color foreground) {
    if (imagePath == null) {
      return Icon(icon, size: 20, color: foreground);
    }

    // The illustration ships with a baked-in white background, so we present it
    // on an intentional white tile — this reads cleanly on the dark sidebar in
    // both light and dark themes (instead of a stray white box).
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: AppImageAssetPreviewer(
        imagePath!,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        // If the (light/dark) asset isn't present yet, fall back to the icon
        // instead of showing a broken-image box.
        // errorBuilder: (_, _, _) => Icon(icon, size: 20, color: foreground),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.color;
    // Active row is a teal pill (white reads on it in both themes); inactive
    // text follows the theme so it stays readable on the now-light sidebar.
    final foreground = isActive ? Colors.white : colors.textPrimary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          final scaffold = Scaffold.maybeOf(context);

          if (scaffold?.isDrawerOpen ?? false) {
            Navigator.pop(context);
          }

          context.go(route);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: isActive ? colors.sidebarActive : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildLeading(foreground),
              const SizedBox(width: 12),
              Expanded(
                child: TextApp(
                  text: label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: TextStyle(
                    color: foreground,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
              if (badgeCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badgeCount > 99 ? '99+' : '$badgeCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
