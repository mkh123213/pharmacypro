import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/extensions/context_extension.dart';
import 'package:pharmacypro/core/language/lang_keys.dart';

import '../../../../core/common/toast/show_toast.dart';
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

    state.whenOrNull(
      loaded: (items, branches, search, role, submitting) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return BlocProvider.value(
              value: context.read<StaffCubit>(),
              child: StaffFormBottomSheet(staff: staff, branches: branches),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StaffCubit, StaffState>(
      listenWhen: (previous, current) => current is StaffFailure,
      listener: (context, state) {
        if (state is StaffFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<StaffCubit, StaffState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              return const SizedBox.shrink();
            },
            loading: () {
              return const AppLoading();
            },
            failure: (message) {
              return _StaffErrorView(
                message: context.translate(message),
                onRetry: () {
                  context.read<StaffCubit>().getStaffData();
                },
              );
            },
            loaded: (staff, branches, searchQuery, selectedRole, isSubmitting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppPageHeader(
                    title: context.translate(LangKeys.staff),
                    subtitle: context.translate(
                      LangKeys.manageEmployeesAcrossAllBranches,
                    ),
                    action: AppPrimaryButton(
                      text: context.translate(LangKeys.addStaff),
                      icon: Icons.add,
                      onPressed: isSubmitting
                          ? null
                          : () {
                              _openForm(context);
                            },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 700;

                      if (wide) {
                        return Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: context
                                    .read<StaffCubit>()
                                    .updateSearchQuery,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  hintText: context.translate(
                                    LangKeys.searchStaff,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            SizedBox(
                              width: 200.w,
                              child: _RoleDropdown(selectedRole: selectedRole),
                            ),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          TextField(
                            onChanged: context
                                .read<StaffCubit>()
                                .updateSearchQuery,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: context.translate(LangKeys.searchStaff),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _RoleDropdown(selectedRole: selectedRole),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: staff.isEmpty
                        ? AppEmptyState(
                            title: context.translate(LangKeys.noStaffFound),
                            message:
                                searchQuery.trim().isEmpty &&
                                    selectedRole == allStaffRolesValue
                                ? context.translate(
                                    LangKeys.addYourFirstStaffMember,
                                  )
                                : context.translate(
                                    LangKeys.noStaffMembersMatchYourFilters,
                                  ),
                            icon: Icons.people_outline,
                          )
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              final count = constraints.maxWidth >= 1100
                                  ? 3
                                  : constraints.maxWidth >= 700
                                  ? 2
                                  : 1;

                              return GridView.builder(
                                itemCount: staff.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: count,
                                      crossAxisSpacing: 16.w,
                                      mainAxisSpacing: 16.h,
                                      childAspectRatio: count == 1
                                          ? 1.55
                                          : 1.15,
                                    ),
                                itemBuilder: (_, index) {
                                  final staffMember = staff[index];

                                  return StaffCard(
                                    staff: staffMember,
                                    onEditPressed: () {
                                      _openForm(context, staff: staffMember);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _RoleDropdown extends StatelessWidget {
  const _RoleDropdown({required this.selectedRole});

  final String selectedRole;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedRole,
      decoration: InputDecoration(labelText: context.translate(LangKeys.role)),
      items: staffRoleOptions.map((role) {
        return DropdownMenuItem<String>(
          value: role,
          child: TextApp(
            text: formatStaffRole(context, role),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        context.read<StaffCubit>().updateSelectedRole(value);
      },
    );
  }
}

class _StaffErrorView extends StatelessWidget {
  const _StaffErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: Colors.red.shade400),
            SizedBox(height: 12.h),
            TextApp(
              text: message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            SizedBox(height: 16.h),
            AppPrimaryButton(
              text: context.translate(LangKeys.retry),
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
