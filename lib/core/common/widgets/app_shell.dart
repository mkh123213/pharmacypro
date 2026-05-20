import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_sidebar.dart';
import 'app_top_bar.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isTablet = width >= 768;

    if (isTablet) {
      return Scaffold(
        body: Row(
          children: [
            const AppSidebar(),
            Expanded(
              child: Column(
                children: [
                  const AppTopBar(),
                  const Divider(height: 1),
                  Expanded(
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: AppTopBar(showMenuButton: true),
      ),
      drawer: const Drawer(child: AppSidebar()),
      body: SafeArea(
        top: false,
        child: Padding(padding: EdgeInsets.all(16.w), child: child),
      ),
    );
  }
}
