part of 'purchase_orders_table.dart';

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92.w,
            child: TextApp(
              text: label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(
                color: Colors.grey,
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
              theme: context.textStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
