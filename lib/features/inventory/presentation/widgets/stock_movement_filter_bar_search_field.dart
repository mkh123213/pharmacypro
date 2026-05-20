part of 'stock_movement_filter_bar.dart';

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onSearchChanged});

  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: context.translate(LangKeys.searchStockMovements),
      ),
    );
  }
}
