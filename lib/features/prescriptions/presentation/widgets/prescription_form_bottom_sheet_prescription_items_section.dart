part of 'prescription_form_bottom_sheet.dart';

class _PrescriptionItemsSection extends StatelessWidget {
  const _PrescriptionItemsSection({
    required this.items,
    required this.onAddPressed,
    required this.onRemovePressed,
  });

  final List<PrescriptionItemModel> items;
  final VoidCallback onAddPressed;
  final ValueChanged<int> onRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextApp(
                text: context.translate(LangKeys.prescriptionItems),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add),
              label: TextApp(
                text: context.translate(LangKeys.addItem),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        if (items.isEmpty)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextApp(
              text: context.translate(LangKeys.noPrescriptionItems),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) => Divider(height: 12.h),
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: TextApp(
                  text: item.medicationName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                subtitle: TextApp(
                  text:
                      '${context.translate(LangKeys.qty)}: ${item.quantity ?? 0}'
                      ' · ${item.dosage ?? context.translate(LangKeys.noDosage)}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                trailing: IconButton(
                  onPressed: () {
                    onRemovePressed(index);
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              );
            },
          ),
      ],
    );
  }
}
