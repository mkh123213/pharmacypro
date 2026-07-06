import 'package:flutter/material.dart';

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
                    child: _ShellContent(width: width, child: child),
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
      body: _ShellContent(width: width, child: child),
    );
  }
}

class _ShellContent extends StatelessWidget {
  const _ShellContent({required this.width, required this.child});

  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final padding = width >= 1200 ? 24.0 : (width >= 768 ? 20.0 : 16.0);

    return SafeArea(
      top: false,
      child: Padding(padding: EdgeInsets.all(padding), child: child),
    );
  }
}
