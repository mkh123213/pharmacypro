part of 'inventory_alerts_body.dart';

class _AlertsSummary extends StatelessWidget {
  const _AlertsSummary({required this.alertsCount});

  final int alertsCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber,
              size: 26.sp,
              color: alertsCount > 0 ? Colors.orange : Colors.green,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextApp(
                text: alertsCount > 0
                    ? context
                          .translate(LangKeys.inventoryAlertsCount)
                          .replaceAll('{count}', alertsCount.toString())
                    : context.translate(LangKeys.noActiveInventoryAlerts),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
