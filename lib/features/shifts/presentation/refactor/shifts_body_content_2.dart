part of 'shifts_body.dart';

extension ShiftsBodyContent2 on ShiftsBody {
  List<Widget> _buildShiftsContent2(BuildContext context, dynamic state) {
    return [
                  state.shifts.isEmpty
                      ? AppEmptyState(
                          title: context.translate(LangKeys.noShiftsFound),
                          message:
                              state.searchQuery.trim().isEmpty &&
                                  state.selectedStatus ==
                                      allShiftStatusesValue &&
                                  state.selectedBranchId ==
                                      allShiftBranchesValue &&
                                  state.selectedStaffId == allShiftStaffValue
                              ? context.translate(LangKeys.addYourFirstShift)
                              : context.translate(
                                  LangKeys.noShiftsMatchYourFilters,
                                ),
                          icon: Icons.calendar_month_outlined,
                        )
                      : ShiftsTable(
                          shifts: state.shifts,
                          isSubmitting: state.isSubmitting,
                          onNextStatus: (shift) {
                            this._moveShiftNext(context: context, shift: shift);
                          },
                          onCancel: (shift) {
                            this._confirmCancelShift(context, shift);
                          },
                        ),
    ];
  }
}
