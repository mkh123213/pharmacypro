part of 'shifts_body.dart';

class _WeekNavigation extends StatelessWidget {
  const _WeekNavigation({required this.state});

  final ShiftsLoaded state;

  @override
  Widget build(BuildContext context) {
    final weekEnd = state.weekStart.add(const Duration(days: 6));

    return Row(
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
        SizedBox(width: 8.w),
        Expanded(
          child: TextApp(
            text: '${_formatDate(state.weekStart)} - ${_formatDate(weekEnd)}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(width: 8.w),
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
    );
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}
