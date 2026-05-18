import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/branch_model.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({required this.branch, required this.onEditPressed, super.key});

  final BranchModel branch;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(25), child: const Icon(Icons.store_outlined)),
                SizedBox(width: 12.w),
                Expanded(child: Text(branch.name, style: const TextStyle(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
                IconButton(onPressed: onEditPressed, icon: const Icon(Icons.edit_outlined)),
              ],
            ),
            if ((branch.city ?? '').isNotEmpty) Text(branch.city!),
            const SizedBox(height: 12),
            _Info(icon: Icons.location_on_outlined, text: branch.address),
            if ((branch.phone ?? '').isNotEmpty) _Info(icon: Icons.phone_outlined, text: branch.phone!),
            if ((branch.email ?? '').isNotEmpty) _Info(icon: Icons.mail_outline, text: branch.email!),
            if ((branch.managerName ?? '').isNotEmpty) _Info(icon: Icons.person_outline, text: branch.managerName!),
            if ((branch.openingHours ?? '').isNotEmpty) _Info(icon: Icons.schedule_outlined, text: branch.openingHours!),
            const Spacer(),
            Chip(label: Text(branch.isActive ? 'Open' : 'Closed'), backgroundColor: branch.isActive ? Colors.green.shade50 : Colors.red.shade50),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(children: [Icon(icon, size: 15, color: Colors.grey), const SizedBox(width: 8), Expanded(child: Text(text, maxLines: 2, overflow: TextOverflow.ellipsis))]),
  );
}
