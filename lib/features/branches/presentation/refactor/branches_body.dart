import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/common/widgets/app_search_icon.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_delete_confirmation_dialog.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/branch_model.dart';
import '../cubit/branches_cubit.dart';
import '../cubit/branches_state.dart';
import '../widgets/branch_card.dart';
import '../widgets/branch_form_bottom_sheet.dart';

part 'branches_body_branch_status_dropdown.dart';
part 'branches_body_branches_error_view.dart';
part 'branches_body_branches_filters.dart';
part 'branches_body_branches_grid.dart';
part 'branches_body_build_branch_error_message.dart';
part 'branches_body_open_form.dart';

class BranchesBody extends StatelessWidget {
  const BranchesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BranchesCubit, BranchesState>(
      listenWhen: (previous, current) => current is BranchesFailure,
      listener: (context, state) {
        if (state is BranchesFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<BranchesCubit, BranchesState>(
        builder: (context, state) {
          if (state is BranchesLoading) {
            return const AppLoading();
          }

          if (state is BranchesFailure) {
            return _BranchesErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<BranchesCubit>().getBranches();
              },
            );
          }

          if (state is! BranchesLoaded) {
            return const SizedBox.shrink();
          }

          final subtitle = context
              .translate(LangKeys.managingBranches)
              .replaceAll('{count}', state.branches.length.toString());

          return RefreshIndicator(
            onRefresh: context.read<BranchesCubit>().getBranches,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppPageHeader(
                    title: context.translate(LangKeys.branches),
                    subtitle: subtitle,
                    action: AppPrimaryButton(
                      text: context.translate(LangKeys.addBranch),
                      icon: Icons.add,
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              _openForm(context, state);
                            },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _BranchesFilters(state: state),
                  SizedBox(height: 20.h),
                  if (state.errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: TextApp(
                        text: buildBranchErrorMessage(
                          context,
                          state.errorMessage!,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle.copyWith(color: Colors.red),
                      ),
                    ),
                  state.branches.isEmpty
                      ? AppEmptyState(
                          title: context.translate(LangKeys.noBranchesYet),
                          message:
                              state.searchQuery.trim().isEmpty &&
                                  state.selectedStatus == 'all'
                              ? context.translate(LangKeys.addYourFirstBranch)
                              : context.translate(
                                  LangKeys.noBranchesMatchYourFilters,
                                ),
                          imagePath: context.assets.noBranchesYet,
                        )
                      : _BranchesGrid(
                          branches: state.branches,
                          onEditPressed: (branch) {
                            _openForm(context, state, branch: branch);
                          },
                          onDeletePressed: (branch) async {
                            final confirmed =
                                await showDeleteConfirmationDialog(
                                  context: context,
                                  title: context.translate(
                                    LangKeys.deleteBranch,
                                  ),
                                  message: context.translate(
                                    LangKeys.deleteBranchConfirmation,
                                  ),
                                );

                            if (confirmed != true || !context.mounted) return;

                            final success = await context
                                .read<BranchesCubit>()
                                .deleteBranch(branch.id);

                            if (!context.mounted) return;

                            if (success) {
                              ShowToast.showToastSuccessTop(
                                message: context.translate(
                                  LangKeys.branchDeletedSuccessfully,
                                ),
                              );
                            }
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
