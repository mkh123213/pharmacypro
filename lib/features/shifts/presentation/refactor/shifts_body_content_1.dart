part of 'shifts_body.dart';

extension ShiftsBodyContent1 on ShiftsBody {
  List<Widget> _buildShiftsContent1(BuildContext context, dynamic state) {
    return [
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
                              this._openForm(context, state);
                            },
                    ),
                  ),
                  SizedBox(height: 14.h),
                  _ShiftFilters(state: state),
                  SizedBox(height: 14.h),
                  _WeekNavigation(state: state),
                  SizedBox(height: 14.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 900.w,
                      child: ShiftWeekView(
                        weekStart: state.weekStart,
                        shifts: state.shifts,
                        isSubmitting: state.isSubmitting,
                        onShiftTap: (shift) {
                          this._moveShiftNext(context: context, shift: shift);
                        },
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
    ];
  }
}
