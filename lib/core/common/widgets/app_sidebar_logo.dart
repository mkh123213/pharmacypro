import 'package:flutter/material.dart';

import 'text_app.dart';

class AppSidebarLogo extends StatelessWidget {
  const AppSidebarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.centerLeft,
      child: const Row(
        children: [
          Icon(Icons.local_pharmacy_outlined, color: Colors.white, size: 30),
          SizedBox(width: 12),
          Expanded(
            child: TextApp(
              text: 'PharmaChain',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
