part of 'purchase_order_details_bottom_sheet.dart';

class _DetailsRow extends StatelessWidget {
  const _DetailsRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130.w,
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
