part of 'inventory_body.dart';

class _InventoryHeaderActions extends StatelessWidget {
  const _InventoryHeaderActions({
    required this.isSubmitting,
    required this.onAddStock,
  });

  final bool isSubmitting;
  final VoidCallback onAddStock;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final compact = screenWidth < 760;

    if (compact) {
      return PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (value) {
          switch (value) {
            case 'alerts':
              context.push(AppRoutes.inventoryAlerts);
              break;
            case 'history':
              context.push(AppRoutes.stockHistory);
              break;
            case 'add':
              if (!isSubmitting) {
                onAddStock();
              }
              break;
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem<String>(
              value: 'alerts',
              child: TextApp(
                text: context.translate(LangKeys.alerts),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            PopupMenuItem<String>(
              value: 'history',
              child: TextApp(
                text: context.translate(LangKeys.stockHistory),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            PopupMenuItem<String>(
              value: 'add',
              enabled: !isSubmitting,
              child: TextApp(
                text: context.translate(LangKeys.addStock),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
          ];
        },
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppPrimaryButton(
          text: context.translate(LangKeys.alerts),
          icon: Icons.notifications_outlined,
          onPressed: () {
            context.push(AppRoutes.inventoryAlerts);
          },
        ),
        SizedBox(width: 8.w),
        AppPrimaryButton(
          text: context.translate(LangKeys.stockHistory),
          icon: Icons.history,
          onPressed: () {
            context.push(AppRoutes.stockHistory);
          },
        ),
        SizedBox(width: 8.w),
        AppPrimaryButton(
          text: context.translate(LangKeys.addStock),
          icon: Icons.add,
          onPressed: isSubmitting ? null : onAddStock,
        ),
      ],
    );
  }
}
