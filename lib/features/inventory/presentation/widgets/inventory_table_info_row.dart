part of 'inventory_table.dart';

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.isWarning = false,
  });

  final String label;
  final String value;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 94.w,
            child: TextApp(
              text: label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(
                color: context.color.textSecondary,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextApp(
              text: value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: isWarning ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
