import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/context_extension.dart';
import 'text_app.dart';

class AppSidebarItem extends StatelessWidget {
  const AppSidebarItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.isActive,
    this.badgeCount = 0,
    super.key,
  });

  final IconData icon;
  final String label;
  final String route;
  final bool isActive;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;

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
              Icon(icon, size: 20, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: TextApp(
                  text: label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: TextStyle(
                    color: Colors.white,
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
