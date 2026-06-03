part of 'branches_body.dart';

class _BranchStatusDropdown extends StatelessWidget {
  const _BranchStatusDropdown({required this.selectedStatus});

  final String selectedStatus;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedStatus,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.status),
      ),
      items: [
        DropdownMenuItem<String>(
          value: 'all',
          child: TextApp(
            text: context.translate(LangKeys.allStatuses),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
        DropdownMenuItem<String>(
          value: 'active',
          child: TextApp(
            text: context.translate(LangKeys.active),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
        DropdownMenuItem<String>(
          value: 'inactive',
          child: TextApp(
            text: context.translate(LangKeys.inactive),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        ),
      ],
      onChanged: (value) {
        context.read<BranchesCubit>().updateSelectedStatus(value ?? 'all');
      },
    );
  }
}
