part of 'branches_body.dart';

extension BranchesBodyOpenForm on BranchesBody {
void _openForm(
    BuildContext context,
    BranchesLoaded state, {
    BranchModel? branch,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BranchesCubit>(),
          child: BranchFormBottomSheet(branch: branch),
        );
      },
    );
  }
}
