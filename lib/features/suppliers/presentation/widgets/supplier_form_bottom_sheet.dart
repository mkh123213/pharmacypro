import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_bottom_sheet_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_switch_field.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../data/models/supplier_model.dart';
import '../cubit/suppliers_cubit.dart';
import '../cubit/suppliers_state.dart';
import '../refactor/suppliers_body.dart';

part 'supplier_form_bottom_sheet_supplier_form_bottom_sheet_state.dart';

part 'supplier_form_bottom_sheet_supplier_form_bottom_sheet_state_empty_to_null.dart';
part 'supplier_form_bottom_sheet_supplier_form_bottom_sheet_state_failure_message.dart';
part 'supplier_form_bottom_sheet_supplier_form_bottom_sheet_state_save.dart';

part 'supplier_form_bottom_sheet_supplier_form_bottom_sheet_state_fields_1.dart';
part 'supplier_form_bottom_sheet_supplier_form_bottom_sheet_state_fields_2.dart';

class SupplierFormBottomSheet extends StatefulWidget {
  const SupplierFormBottomSheet({this.supplier, super.key});

  final SupplierModel? supplier;

  @override
  State<SupplierFormBottomSheet> createState() {
    return _SupplierFormBottomSheetState();
  }
}
