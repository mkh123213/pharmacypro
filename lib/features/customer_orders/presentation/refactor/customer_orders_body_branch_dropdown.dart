part of 'customer_orders_body.dart';

class _BranchDropdown extends StatelessWidget {
  const _BranchDropdown({
    required this.selectedBranchId,
    required this.branches,
  });

  final String selectedBranchId;
  final List<BranchModel> branches;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedBranchId,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.branch),
      ),
      items: [
        DropdownMenuItem<String>(
          value: 'all',
          child: TextApp(
            text: context.translate(LangKeys.allBranches),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
        ...branches.map((branch) {
          return DropdownMenuItem<String>(
            value: branch.id,
            child: TextApp(
              text: branch.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          );
        }),
      ],
      onChanged: (value) {
        context.read<CustomerOrdersCubit>().updateSelectedBranch(
          value ?? 'all',
        );
      },
    );
  }
}
