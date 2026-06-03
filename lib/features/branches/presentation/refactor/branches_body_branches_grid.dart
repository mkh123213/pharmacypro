part of 'branches_body.dart';

class _BranchesGrid extends StatelessWidget {
  const _BranchesGrid({required this.branches, required this.onEditPressed, required this.onDeletePressed});

  final List<BranchModel> branches;
  final ValueChanged<BranchModel> onEditPressed;
  final ValueChanged<BranchModel> onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1100
            ? 3
            : constraints.maxWidth >= 700
            ? 2
            : 1;

        return GridView.builder(
          itemCount: branches.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.h,
            childAspectRatio: count == 1 ? 1.38 : 1.08,
          ),
          itemBuilder: (_, index) {
            final branch = branches[index];

            return BranchCard(
              branch: branch,
              onEditPressed: () {
                onEditPressed(branch);
              },
              onDeletePressed: () {
                onDeletePressed(branch);
              },
            );
          },
        );
      },
    );
  }
}
