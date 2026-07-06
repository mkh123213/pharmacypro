part of 'medications_body.dart';

class _MedicationsFilters extends StatelessWidget {
  const _MedicationsFilters({required this.state});

  final MedicationsLoaded state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;

        final search = TextField(
          onChanged: context.read<MedicationsCubit>().updateSearchQuery,
          decoration: InputDecoration(
            prefixIcon: AppSearchIcon(),
            hintText: context.translate(LangKeys.searchMedication),
          ),
        );

        final category = _CategoryDropdown(
          selectedCategory: state.selectedCategory,
        );

        final status = _MedicationStatusDropdown(
          selectedStatus: state.selectedStatus,
        );

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: search),
              SizedBox(width: 12.w),
              SizedBox(width: 220.w, child: category),
              SizedBox(width: 12.w),
              SizedBox(width: 180.w, child: status),
            ],
          );
        }

        return Column(
          children: [
            search,
            SizedBox(height: 12.h),
            category,
            SizedBox(height: 12.h),
            status,
          ],
        );
      },
    );
  }
}
