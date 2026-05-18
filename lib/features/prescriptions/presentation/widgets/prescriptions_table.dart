import 'package:flutter/material.dart';
import '../../data/models/prescription_model.dart';

class PrescriptionsTable extends StatelessWidget {
  const PrescriptionsTable({required this.prescriptions, required this.onView, required this.onVerify, required this.onReject, required this.onDispense, super.key});
  final List<PrescriptionModel> prescriptions;
  final ValueChanged<PrescriptionModel> onView;
  final ValueChanged<PrescriptionModel> onVerify;
  final ValueChanged<PrescriptionModel> onReject;
  final ValueChanged<PrescriptionModel> onDispense;
  @override
  Widget build(BuildContext context) => Card(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: const [DataColumn(label: Text('#')), DataColumn(label: Text('Patient')), DataColumn(label: Text('Doctor')), DataColumn(label: Text('Branch')), DataColumn(label: Text('Status')), DataColumn(label: Text('Actions'))], rows: prescriptions.map((p) => DataRow(cells: [DataCell(Text(p.prescriptionNumber ?? p.id)), DataCell(Text(p.patientName)), DataCell(Text(p.doctorName ?? '—')), DataCell(Text(p.branchName ?? '—')), DataCell(Chip(label: Text(p.status))), DataCell(Row(children: [IconButton(onPressed: () => onView(p), icon: const Icon(Icons.visibility_outlined)), if (p.status == 'pending') IconButton(onPressed: () => onVerify(p), icon: const Icon(Icons.check_circle_outline)), if (p.status == 'pending') IconButton(onPressed: () => onReject(p), icon: const Icon(Icons.cancel_outlined)), if (p.status == 'verified') TextButton(onPressed: () => onDispense(p), child: const Text('Dispense'))]))])).toList())));
}
