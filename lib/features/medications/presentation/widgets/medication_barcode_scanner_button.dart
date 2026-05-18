import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MedicationBarcodeScannerButton extends StatelessWidget {
  const MedicationBarcodeScannerButton({required this.onScan, super.key});

  final ValueChanged<String> onScan;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Scan barcode'),
            content: SizedBox(
              width: 320,
              height: 320,
              child: MobileScanner(
                onDetect: (capture) {
                  if (capture.barcodes.isEmpty) return;
                  final code = capture.barcodes.first.rawValue;
                  if (code == null || code.isEmpty) return;
                  Navigator.pop(context);
                  onScan(code);
                },
              ),
            ),
          ),
        );
      },
      icon: const Icon(Icons.qr_code_scanner),
      label: const Text('Scan'),
    );
  }
}
