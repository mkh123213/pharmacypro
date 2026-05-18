import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../data/models/medication_model.dart';

void showMedicationQrCodeBottomSheet(BuildContext context, MedicationModel medication) {
  final code = (medication.barcode == null || medication.barcode!.isEmpty) ? medication.id : medication.barcode!;
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      child: SafeArea(
        top: false,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextApp(text: 'QR Code', theme: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.h),
          QrImageView(data: code, version: QrVersions.auto, size: 180.w),
          SizedBox(height: 12.h),
          TextApp(text: medication.name, theme: Theme.of(context).textTheme.titleMedium),
          if ((medication.strength ?? '').isNotEmpty) TextApp(text: medication.strength!, theme: Theme.of(context).textTheme.bodySmall),
          TextApp(text: code, theme: Theme.of(context).textTheme.bodySmall),
        ]),
      ),
    ),
  );
}
