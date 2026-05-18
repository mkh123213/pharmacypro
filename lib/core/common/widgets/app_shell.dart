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
                    child: Padding(padding: EdgeInsets.all(24.w), child: child),
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
        preferredSize: Size.fromHeight(56),
        child: AppTopBar(showMenuButton: true),
      ),
      drawer: const Drawer(child: AppSidebar()),
      body: Padding(padding: EdgeInsets.all(16.w), child: child),
    );
  }
}
