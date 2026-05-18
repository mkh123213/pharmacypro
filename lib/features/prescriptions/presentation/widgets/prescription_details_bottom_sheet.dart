import 'package:flutter/material.dart';
import '../../data/models/prescription_model.dart';

void showPrescriptionDetailsBottomSheet(BuildContext context, PrescriptionModel prescription) {
  showModalBottomSheet(context: context, builder: (_) => SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Prescription Details', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 12),
    Text('Patient: ${prescription.patientName}'), Text('Doctor: ${prescription.doctorName ?? '—'}'), Text('Status: ${prescription.status}'), const SizedBox(height: 12),
    ...prescription.items.map((item) => ListTile(title: Text(item.medicationName ?? ''), subtitle: Text('${item.dosage ?? ''} · Qty: ${item.quantity ?? 0}'))),
  ]))));
}
