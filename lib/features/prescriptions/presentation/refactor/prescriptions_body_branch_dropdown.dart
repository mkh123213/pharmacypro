part of 'prescriptions_body.dart';

class _BranchDropdown extends StatelessWidget {
  const _BranchDropdown({
    required this.branches,
    required this.selectedBranchId,
  });

  final List<dynamic> branches;
  final String selectedBranchId;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedBranchId,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.branch),
      ),
      items: [
        DropdownMenuItem<String>(
          value: allPrescriptionBranchesValue,
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
        context.read<PrescriptionsCubit>().updateSelectedBranch(
          value ?? allPrescriptionBranchesValue,
        );
      },
    );
  }
}
