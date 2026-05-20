import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/purchase_order_model.dart';
import '../refactor/purchase_orders_constants.dart';

part 'purchase_order_details_bottom_sheet_details_row.dart';
part 'purchase_order_details_bottom_sheet_details_section.dart';
part 'purchase_order_details_bottom_sheet_purchase_order_details_bottom_sheet.dart';

part 'purchase_order_details_bottom_sheet_purchase_order_details_bottom_sheet_empty_fallback.dart';
part 'purchase_order_details_bottom_sheet_purchase_order_details_bottom_sheet_format_date_time.dart';
part 'purchase_order_details_bottom_sheet_purchase_order_details_bottom_sheet_next_action_label.dart';
part 'purchase_order_details_bottom_sheet_purchase_order_details_bottom_sheet_status_type.dart';

part 'purchase_order_details_bottom_sheet_purchase_order_details_bottom_sheet_content_1.dart';
part 'purchase_order_details_bottom_sheet_purchase_order_details_bottom_sheet_content_2.dart';
part 'purchase_order_details_bottom_sheet_purchase_order_details_bottom_sheet_content_3.dart';
part 'purchase_order_details_bottom_sheet_purchase_order_details_bottom_sheet_content_4.dart';

void showPurchaseOrderDetailsBottomSheet(
  BuildContext context,
  PurchaseOrderModel order, {
  ValueChanged<PurchaseOrderModel>? onEdit,
  ValueChanged<PurchaseOrderModel>? onNextStatus,
  ValueChanged<PurchaseOrderModel>? onCancel,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _PurchaseOrderDetailsBottomSheet(
        order: order,
        onEdit: onEdit,
        onNextStatus: onNextStatus,
        onCancel: onCancel,
      );
    },
  );
}
