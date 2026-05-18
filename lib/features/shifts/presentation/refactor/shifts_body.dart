import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/shift_model.dart';
import '../cubit/shifts_cubit.dart';
import '../cubit/shifts_state.dart';
import '../widgets/shift_form_bottom_sheet.dart';
import '../widgets/shift_week_view.dart';
import '../widgets/shifts_table.dart';
import 'shifts_constants.dart';

class ShiftsBody extends StatelessWidget {
  const ShiftsBody({super.key});

  void _openForm(BuildContext context, ShiftsLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<ShiftsCubit>(),
          child: ShiftFormBottomSheet(
            staff: state.staff,
            branches: state.branches,
          ),
        );
      },
    );
  }

  Future<void> _updateShiftStatus({
    required BuildContext context,
    required ShiftModel shift,
  }) async {
    final nextStatus = nextShiftStatus(shift.status);

    if (nextStatus == shift.status) return;

    final success = await context.read<ShiftsCubit>().updateStatus(
      shift.id,
      nextStatus,
    );

    if (!context.mounted) return;

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotUpdateShiftStatus),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.shiftStatusUpdatedSuccessfully),
    );
  }

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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppPageHeader(
                title: context.translate(LangKeys.shifts),
                subtitle: context.translate(
                  LangKeys.scheduleAndTrackStaffShifts,
                ),
                action: AppPrimaryButton(
                  text: context.translate(LangKeys.addShift),
                  icon: Icons.add,
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          _openForm(context, state);
                        },
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: context.read<ShiftsCubit>().previousWeek,
                    child: TextApp(
                      text: context.translate(LangKeys.prevWeek),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: context.read<ShiftsCubit>().nextWeek,
                    child: TextApp(
                      text: context.translate(LangKeys.nextWeek),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              SizedBox(
                height: 240.h,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 900.w,
                    child: ShiftWeekView(
                      weekStart: state.weekStart,
                      shifts: state.shifts,
                      isSubmitting: state.isSubmitting,
                      onShiftTap: (shift) {
                        _updateShiftStatus(context: context, shift: shift);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TextApp(
                text: context.translate(LangKeys.allUpcomingShifts),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: state.shifts.isEmpty
                    ? _EmptyShiftsView()
                    : ShiftsTable(shifts: state.shifts),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyShiftsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextApp(
        text: context.translate(LangKeys.noShiftsFound),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        theme: context.textStyle,
      ),
    );
  }
}

class _ShiftsErrorView extends StatelessWidget {
  const _ShiftsErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: Colors.red.shade400),
            SizedBox(height: 12.h),
            TextApp(
              text: message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            SizedBox(height: 16.h),
            AppPrimaryButton(
              text: context.translate(LangKeys.retry),
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
