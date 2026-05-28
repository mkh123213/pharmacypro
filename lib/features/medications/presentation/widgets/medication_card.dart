import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_card.dart';
import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/medication_model.dart';
import '../refactor/medications_constants.dart';
import 'medication_qr_code_bottom_sheet.dart';

part 'medication_card_content_1.dart';
part 'medication_card_content_2.dart';

class MedicationCard extends StatelessWidget {
  const MedicationCard({
    required this.medication,
    required this.onEditPressed,
    required this.onDeletePressed,
    super.key,
  });

  final MedicationModel medication;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...this._buildMedicationCardContent1(context),
            ...this._buildMedicationCardContent2(context),
          ],
        ),
      ),
    );
  }
}
