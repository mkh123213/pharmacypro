import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../data/models/shift_model.dart';
import 'shift_card.dart';

class ShiftWeekView extends StatelessWidget {
  const ShiftWeekView({
    required this.weekStart,
    required this.shifts,
    required this.onShiftTap,
    this.isSubmitting = false,
    super.key,
  });

  final DateTime weekStart;
  final List<ShiftModel> shifts;
  final ValueChanged<ShiftModel> onShiftTap;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final days = List.generate(
      7,
      (index) => weekStart.add(Duration(days: index)),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: days.map((day) {
        final key = DateFormat('yyyy-MM-dd').format(day);
        final dayShifts = shifts.where((shift) => shift.date == key).toList();
        final isToday = DateUtils.isSameDay(day, DateTime.now());

        return Expanded(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: isToday
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade200,
                child: Column(
                  children: [
                    TextApp(
                      text: DateFormat('EEE').format(day),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        color: isToday ? Colors.white : null,
                      ),
                    ),
                    TextApp(
                      text: DateFormat('d').format(day),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        color: isToday ? Colors.white : null,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              ...dayShifts.map((shift) {
                return ShiftCard(
                  shift: shift,
                  isSubmitting: isSubmitting,
                  onTap: () {
                    onShiftTap(shift);
                  },
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }
}
