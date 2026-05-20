import 'package:flutter/material.dart';
import '../../../features/medications/data/models/medication_model.dart';

import 'sale_medication_picker_content.dart';
import 'sale_medication_picker_filter.dart';

class SaleMedicationPickerResult {
  const SaleMedicationPickerResult({
    required this.medication,
    required this.quantity,
  });

  final MedicationModel medication;
  final int quantity;
}

Future<SaleMedicationPickerResult?> showSaleMedicationPickerBottomSheet({
  required BuildContext context,
  required List<MedicationModel> medications,
}) {
  return showModalBottomSheet<SaleMedicationPickerResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return SaleMedicationPickerBottomSheet(medications: medications);
    },
  );
}

class SaleMedicationPickerBottomSheet extends StatefulWidget {
  const SaleMedicationPickerBottomSheet({required this.medications, super.key});

  final List<MedicationModel> medications;

  @override
  State<SaleMedicationPickerBottomSheet> createState() {
    return _SaleMedicationPickerBottomSheetState();
  }
}

class _SaleMedicationPickerBottomSheetState
    extends State<SaleMedicationPickerBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');

  MedicationModel? _selectedMedication;
  String _searchQuery = '';

  List<MedicationModel> get _filteredMedications {
    return SaleMedicationPickerFilter.apply(
      medications: widget.medications,
      query: _searchQuery,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedMedication == null) return;

    Navigator.pop(
      context,
      SaleMedicationPickerResult(
        medication: _selectedMedication!,
        quantity: int.tryParse(_quantityController.text.trim()) ?? 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SaleMedicationPickerContent(
      formKey: _formKey,
      medications: _filteredMedications,
      selectedMedication: _selectedMedication,
      searchController: _searchController,
      quantityController: _quantityController,
      onSearchChanged: (value) => setState(() => _searchQuery = value),
      onMedicationSelected: (medication) {
        setState(() => _selectedMedication = medication);
      },
      onSubmit: _selectedMedication == null ? null : _submit,
    );
  }
}
