part of 'purchase_orders_body.dart';

class _PurchaseOrderSummaryCard extends StatelessWidget {
  const _PurchaseOrderSummaryCard({required this.data});

  final _PurchaseOrderSummaryCardData data;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: primary.withOpacity(0.10),
              child: Icon(data.icon, color: primary, size: 20.sp),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextApp(
                    text: data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle.copyWith(
                      fontSize: 12.sp,
                      height: 1.1,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    height: 28.h,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: TextApp(
                          text: data.value,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          theme: context.textStyle.copyWith(
                            height: 1,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
