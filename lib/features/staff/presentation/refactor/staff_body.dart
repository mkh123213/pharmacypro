import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_delete_confirmation_dialog.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/staff_model.dart';
import '../cubit/staff_cubit.dart';
import '../cubit/staff_state.dart';
import '../widgets/staff_card.dart';
import '../widgets/staff_form_bottom_sheet.dart';
import 'staff_constants.dart';

part 'staff_body_role_dropdown.dart';
part 'staff_body_staff_error_view.dart';
part 'staff_body_staff_filters.dart';
part 'staff_body_staff_grid.dart';

part 'staff_body_open_form.dart';
class StaffBody extends StatelessWidget {
  const StaffBody({super.key});


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
          if (state is StaffLoading) {
            return const AppLoading();
          }

          if (state is StaffFailure) {
            return _StaffErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<StaffCubit>().getStaffData();
              },
            );
          }

          if (state is! StaffLoaded) {
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
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
                    onPressed: state.isSubmitting
                        ? null
                        : () {
                            this._openForm(context, state);
                          },
                  ),
                ),
                SizedBox(height: 16.h),
                _StaffFilters(state: state),
                SizedBox(height: 20.h),
                state.staff.isEmpty
                    ? AppEmptyState(
                        title: context.translate(LangKeys.noStaffFound),
                        message:
                            state.searchQuery.trim().isEmpty &&
                                state.selectedRole == allStaffRolesValue
                            ? context.translate(
                                LangKeys.addYourFirstStaffMember,
                              )
                            : context.translate(
                                LangKeys.noStaffMembersMatchYourFilters,
                              ),
                        icon: Icons.people_outline,
                      )
                    : _StaffGrid(
                        staff: state.staff,
                        onEditPressed: (staffMember) {
                          this._openForm(context, state, staff: staffMember);
                        },
                        onDeletePressed: (staffMember) async {
                          final confirmed = await showDeleteConfirmationDialog(
                            context: context,
                            title: context.translate(LangKeys.deleteStaff),
                            message: context.translate(LangKeys.deleteStaffConfirmation),
                          );

                          if (confirmed != true || !context.mounted) return;

                          final success = await context.read<StaffCubit>().deleteStaff(staffMember.id);

                          if (!context.mounted) return;

                          if (success) {
                            ShowToast.showToastSuccessTop(
                              message: context.translate(LangKeys.staffDeletedSuccessfully),
                            );
                          }
                        },
                      ),
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
