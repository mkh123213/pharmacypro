import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../data/models/staff_model.dart';
import '../cubit/staff_cubit.dart';
import '../cubit/staff_state.dart';
import '../widgets/staff_card.dart';
import '../widgets/staff_form_bottom_sheet.dart';
import 'staff_constants.dart';

class StaffBody extends StatelessWidget {
  const StaffBody({super.key});

  void _openForm(BuildContext context, {StaffModel? staff}) {
    final state = context.read<StaffCubit>().state;
    state.whenOrNull(loaded: (items, branches, search, role, submitting) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => BlocProvider.value(value: context.read<StaffCubit>(), child: StaffFormBottomSheet(staff: staff, branches: branches)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffCubit, StaffState>(builder: (context, state) => state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const AppLoading(),
      failure: (message) => Center(child: TextApp(text: message)),
      loaded: (staff, branches, searchQuery, selectedRole, isSubmitting) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppPageHeader(title: 'Staff', subtitle: 'Manage employees across all branches', action: AppPrimaryButton(text: 'Add Staff', icon: Icons.add, onPressed: () => _openForm(context))),
        SizedBox(height: 16.h),
        LayoutBuilder(builder: (context, constraints) {
          final wide = constraints.maxWidth >= 700;
          return Flex(direction: wide ? Axis.horizontal : Axis.vertical, children: [
            Expanded(flex: wide ? 1 : 0, child: TextField(onChanged: context.read<StaffCubit>().updateSearchQuery, decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search staff...'))),
            SizedBox(width: wide ? 12.w : 0, height: wide ? 0 : 12.h),
            SizedBox(width: wide ? 200.w : double.infinity, child: DropdownButtonFormField<String>(value: selectedRole, decoration: const InputDecoration(labelText: 'Role'), items: staffRoleOptions.map((r) => DropdownMenuItem(value: r, child: Text(formatStaffRole(r)))).toList(), onChanged: (v) { if (v != null) context.read<StaffCubit>().updateSelectedRole(v); })),
          ]);
        }),
        SizedBox(height: 20.h),
        Expanded(child: staff.isEmpty ? AppEmptyState(title: 'No staff found', message: 'Add your first staff member.', icon: Icons.people_outline) : LayoutBuilder(builder: (context, constraints) {
          final count = constraints.maxWidth >= 1100 ? 3 : constraints.maxWidth >= 700 ? 2 : 1;
          return GridView.builder(itemCount: staff.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count, crossAxisSpacing: 16.w, mainAxisSpacing: 16.h, childAspectRatio: count == 1 ? 1.65 : 1.25), itemBuilder: (_, index) => StaffCard(staff: staff[index], onEditPressed: () => _openForm(context, staff: staff[index])));
        })),
      ]),
    ));
  }
}
