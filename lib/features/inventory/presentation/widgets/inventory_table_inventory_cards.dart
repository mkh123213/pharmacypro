part of 'inventory_table.dart';

class _InventoryCards extends StatelessWidget {
  const _InventoryCards({
    required this.items,
    required this.onTap,
    required this.onAdjustStock,
    required this.isSubmitting,
    this.onDelete,
  });

  final List<InventoryModel> items;
  final ValueChanged<InventoryModel> onTap;
  final ValueChanged<InventoryModel> onAdjustStock;
  final bool isSubmitting;
  final ValueChanged<InventoryModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final item = items[index];

        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: isSubmitting
                ? null
                : () {
                    onTap(item);
                  },
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextApp(
                          text: item.medicationName ?? '-',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          theme: context.textStyle.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      _InventoryStatusChip(item: item),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  _InfoRow(
                    label: context.translate(LangKeys.branch),
                    value: item.branchName ?? '-',
                  ),
                  _InfoRow(
                    label: context.translate(LangKeys.qty),
                    value: item.quantity.toString(),
                    isWarning: item.isLowStock,
                  ),
                  _InfoRow(
                    label: context.translate(LangKeys.min),
                    value: item.minStockLevel.toString(),
                  ),
                  _InfoRow(
                    label: context.translate(LangKeys.expiryDate),
                    value: item.expiryDate ?? '—',
                    isWarning: item.isExpired || item.isExpiringSoon,
                  ),
                  if ((item.batchNumber ?? '').isNotEmpty)
                    _InfoRow(
                      label: context.translate(LangKeys.batchNumber),
                      value: item.batchNumber!,
                    ),
                  if ((item.locationInStore ?? '').isNotEmpty)
                    _InfoRow(
                      label: context.translate(LangKeys.locationInStore),
                      value: item.locationInStore!,
                    ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (onDelete != null)
                        TextButton.icon(
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  onDelete!(item);
                                },
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          label: TextApp(
                            text: context.translate(LangKeys.delete),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle.copyWith(color: Colors.red),
                          ),
                        ),
                      TextButton.icon(
                        onPressed: isSubmitting
                            ? null
                            : () {
                                onAdjustStock(item);
                              },
                        icon: const Icon(Icons.tune),
                        label: TextApp(
                          text: context.translate(LangKeys.adjustStock),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          theme: context.textStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
