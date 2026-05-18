import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/supplier_model.dart';

class SupplierCard extends StatelessWidget {
  const SupplierCard({required this.supplier, required this.onEditPressed, super.key});

  final SupplierModel supplier;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(25), child: const Icon(Icons.local_shipping_outlined)),
            const Spacer(),
            IconButton(onPressed: onEditPressed, icon: const Icon(Icons.edit_outlined)),
          ]),
          Text(supplier.name, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          if ((supplier.contactPerson ?? '').isNotEmpty) _Info(icon: Icons.person_outline, text: supplier.contactPerson!),
          if ((supplier.email ?? '').isNotEmpty) _Info(icon: Icons.mail_outline, text: supplier.email!),
          if ((supplier.phone ?? '').isNotEmpty) _Info(icon: Icons.phone_outlined, text: supplier.phone!),
          const Spacer(),
          Row(children: [
            if ((supplier.paymentTerms ?? '').isNotEmpty) Expanded(child: Text(supplier.paymentTerms!, style: const TextStyle(color: Colors.grey))),
            Chip(label: Text(supplier.isActive ? 'Active' : 'Inactive'), backgroundColor: supplier.isActive ? Colors.green.shade50 : Colors.red.shade50),
          ]),
        ]),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(children: [Icon(icon, size: 15, color: Colors.grey), const SizedBox(width: 8), Expanded(child: Text(text, overflow: TextOverflow.ellipsis))]));
}
