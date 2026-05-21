import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/common/widgets/app_bottom_sheet_header.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/medication_model.dart';

void showMedicationQrCodeBottomSheet(
  BuildContext context,
  MedicationModel medication,
) {
  final code = medication.barcode == null || medication.barcode!.isEmpty
      ? medication.id
      : medication.barcode!;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: context.color.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBottomSheetHeader(
                title: context.translate(LangKeys.qrCode),
              ),
              SizedBox(height: 16.h),
              QrImageView(data: code, version: QrVersions.auto, size: 180.w),
              SizedBox(height: 12.h),
              TextApp(
                text: medication.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
              if ((medication.strength ?? '').isNotEmpty)
                TextApp(
                  text: medication.strength!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
              TextApp(
                text: code,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
          ),
        ),
      );
    },
  );
}
