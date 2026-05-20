part of 'prescription_details_bottom_sheet.dart';

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextApp(
            text: '$label: ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: TextApp(
              text: value,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
