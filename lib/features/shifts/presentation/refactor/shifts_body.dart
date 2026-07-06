import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/common/widgets/app_search_icon.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../staff/data/models/staff_model.dart';
import '../../data/models/shift_model.dart';
import '../cubit/shifts_cubit.dart';
import '../cubit/shifts_state.dart';
import '../widgets/shift_form_bottom_sheet.dart';
import '../widgets/shift_week_view.dart';
import '../widgets/shifts_table.dart';
import 'shifts_constants.dart';

part 'shifts_body_branch_dropdown.dart';
part 'shifts_body_shift_filters.dart';
part 'shifts_body_shifts_error_view.dart';
part 'shifts_body_staff_dropdown.dart';
part 'shifts_body_status_dropdown.dart';
part 'shifts_body_week_navigation.dart';

part 'shifts_body_content_1.dart';
part 'shifts_body_content_2.dart';

part 'shifts_body_build_shift_error_message.dart';

part 'shifts_body_confirm_cancel_shift.dart';
part 'shifts_body_move_shift_next.dart';
part 'shifts_body_update_shift_status.dart';
part 'shifts_body_open_form.dart';
class ShiftsBody extends StatelessWidget {
  const ShiftsBody({super.key});





  @override
  Widget build(BuildContext context) {
    return BlocListener<ShiftsCubit, ShiftsState>(
      listenWhen: (previous, current) => current is ShiftsFailure,
      listener: (context, state) {
        if (state is ShiftsFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<ShiftsCubit, ShiftsState>(
        builder: (context, state) {
          if (state is ShiftsLoading) {
            return const AppLoading();
          }

          if (state is ShiftsFailure) {
            return _ShiftsErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<ShiftsCubit>().getShiftsData();
              },
            );
          }

          if (state is! ShiftsLoaded) {
            return const SizedBox.shrink();
          }

          return RefreshIndicator(
            onRefresh: context.read<ShiftsCubit>().getShiftsData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...this._buildShiftsContent1(context, state),
                  ...this._buildShiftsContent2(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
