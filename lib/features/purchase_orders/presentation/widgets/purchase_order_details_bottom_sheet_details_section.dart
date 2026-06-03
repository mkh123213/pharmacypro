part of 'purchase_order_details_bottom_sheet.dart';

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(children: children),
      ),
    );
  }
}
