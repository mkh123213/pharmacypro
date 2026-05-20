part of 'staff_card.dart';

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: Colors.grey.shade600),
          SizedBox(width: 7.w),
          Expanded(
            child: TextApp(
              text: text,
              theme: context.textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
