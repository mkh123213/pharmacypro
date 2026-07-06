import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../features/branches/data/models/branch_model.dart';
import '../../../features/medications/data/models/medication_model.dart';
import '../../../features/medications/presentation/cubit/medications_cubit.dart';
import '../../../features/medications/presentation/widgets/medication_form_bottom_sheet.dart';
import '../../../features/sales/data/models/sale_item_model.dart';
import '../../../features/sales/data/repos/sales_repo.dart';
import '../../../features/sales/presentation/cubit/sales_cubit.dart';
import '../../../features/sales/presentation/widgets/sale_form_bottom_sheet.dart';
import '../../di/dependency_injection.dart';
import '../../extensions/context_extension.dart';
import '../../language/lang_keys.dart';
import '../toast/show_toast.dart';
import 'text_app.dart';

class SmartBarcodeScannerButton extends StatelessWidget {
  const SmartBarcodeScannerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.translate(LangKeys.scanBarcodeToSellOrAdd),
      child: GestureDetector(
        onTap: () => _openScanner(context),
        child: Icon(Icons.qr_code_scanner, color: context.color.textPrimary),
      ),
    );
  }

  void _openScanner(BuildContext context) {
    var hasScanned = false;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: TextApp(
            text: context.translate(LangKeys.scanBarcodeToSellOrAdd),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
            width: 320,
            height: 320,
            child: MobileScanner(
              onDetect: (capture) {
                if (hasScanned) return;
                if (capture.barcodes.isEmpty) return;

                final code = capture.barcodes.first.rawValue;
                if (code == null || code.isEmpty) return;

                hasScanned = true;
                Navigator.pop(dialogContext);

                _handleBarcode(context, code);
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleBarcode(BuildContext context, String barcode) async {
    try {
      final salesRepo = getIt<SalesRepo>();

      final results = await Future.wait([
        salesRepo.getMedications(),
        salesRepo.getBranches(),
      ]);

      final medications = results[0] as List<MedicationModel>;
      final branches = results[1] as List<BranchModel>;

      if (!context.mounted) return;

      final activeMedications = medications.where((m) => m.isActive).toList();

      final match = activeMedications.where((m) {
        return m.barcode != null &&
            m.barcode!.toLowerCase().trim() == barcode.toLowerCase().trim();
      }).toList();

      if (match.isNotEmpty) {
        final med = match.first;

        ShowToast.showToastSuccessTop(
          message: context.translate(LangKeys.medicationFoundStartingSale),
        );

        _openSaleForm(
          context,
          medications: activeMedications,
          branches: branches,
          initialItems: [
            SaleItemModel(
              medicationId: med.id,
              medicationName: med.name,
              quantity: 1,
              unitPrice: med.price,
              total: med.price,
            ),
          ],
        );
      } else {
        ShowToast.showToastSuccessTop(
          message: context.translate(LangKeys.medicationNotFoundAddingNew),
        );

        _openAddMedicationForm(context, barcode);
      }
    } catch (_) {
      if (!context.mounted) return;

      _openAddMedicationForm(context, barcode);
    }
  }

  void _openSaleForm(
    BuildContext context, {
    required List<MedicationModel> medications,
    required List<BranchModel> branches,
    required List<SaleItemModel> initialItems,
  }) {
    final salesCubit = getIt<SalesCubit>();
    salesCubit.getSalesData();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: salesCubit,
          child: SaleFormBottomSheet(
            medications: medications,
            branches: branches,
            initialItems: initialItems,
          ),
        );
      },
    );
  }

  void _openAddMedicationForm(BuildContext context, String barcode) {
    final medicationsCubit = getIt<MedicationsCubit>();
    medicationsCubit.getMedications();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: medicationsCubit,
          child: MedicationFormBottomSheet(initialBarcode: barcode),
        );
      },
    );
  }
}
