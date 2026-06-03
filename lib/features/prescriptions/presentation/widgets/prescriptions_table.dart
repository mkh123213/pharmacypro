import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/prescription_model.dart';
import '../refactor/prescriptions_constants.dart';

part 'prescriptions_table_info_line.dart';
part 'prescriptions_table_prescription_actions.dart';
part 'prescriptions_table_prescription_card.dart';

part 'prescriptions_table_columns.dart';
part 'prescriptions_table_rows.dart';

class PrescriptionsTable extends StatelessWidget {
  const PrescriptionsTable({
    required this.prescriptions,
    required this.onView,
    required this.onVerify,
    required this.onReject,
    required this.onDispense,
    this.isSubmitting = false,
    this.onDelete,
    super.key,
  });

  final List<PrescriptionModel> prescriptions;
  final ValueChanged<PrescriptionModel> onView;
  final ValueChanged<PrescriptionModel> onVerify;
  final ValueChanged<PrescriptionModel> onReject;
  final ValueChanged<PrescriptionModel> onDispense;
  final bool isSubmitting;
  final ValueChanged<PrescriptionModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;

        if (!wide) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: prescriptions.length,
            separatorBuilder: (_, _) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              final prescription = prescriptions[index];

              return _PrescriptionCard(
                prescription: prescription,
                isSubmitting: isSubmitting,
                onView: onView,
                onVerify: onVerify,
                onReject: onReject,
                onDispense: onDispense,
                onDelete: onDelete,
              );
            },
          );
        }

        return Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: this._buildPrescriptionsTableColumns(context),
              rows: this._buildPrescriptionsTableRows(context),
            ),
          ),
        );
      },
    );
  }
}




AppStatusChipType _statusType(String status) {
  switch (status) {
    case 'pending':
      return AppStatusChipType.warning;
    case 'verified':
      return AppStatusChipType.info;
    case 'dispensed':
      return AppStatusChipType.success;
    case 'rejected':
    case 'expired':
      return AppStatusChipType.error;
    default:
      return AppStatusChipType.neutral;
  }
}
