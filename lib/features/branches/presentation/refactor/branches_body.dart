import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/extensions/context_extension.dart';
import 'package:pharmacypro/core/language/lang_keys.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../data/models/branch_model.dart';
import '../cubit/branches_cubit.dart';
import '../cubit/branches_state.dart';
import '../widgets/branch_card.dart';
import '../widgets/branch_form_bottom_sheet.dart';

class BranchesBody extends StatelessWidget {
  const BranchesBody({super.key});

  void _openForm(BuildContext context, {BranchModel? branch}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BranchesCubit>(),
          child: BranchFormBottomSheet(branch: branch),
        );
      },
    );
  }

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
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BranchesFailure) {
            return _ErrorView(
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FeatureHeader(
                title: context.translate(LangKeys.branches),
                subtitle: subtitle,
                action: ElevatedButton.icon(
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          _openForm(context);
                        },
                  icon: const Icon(Icons.add),
                  label: TextApp(
                    text: context.translate(LangKeys.addBranch),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: state.branches.isEmpty
                    ? _EmptyBranchesView(
                        onAddPressed: () {
                          _openForm(context);
                        },
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final count = constraints.maxWidth >= 1000
                              ? 3
                              : constraints.maxWidth >= 650
                              ? 2
                              : 1;

                          return GridView.builder(
                            itemCount: state.branches.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: count,
                                  crossAxisSpacing: 14,
                                  mainAxisSpacing: 14,
                                  childAspectRatio: count == 1 ? 1.45 : 1.15,
                                ),
                            itemBuilder: (_, index) {
                              final branch = state.branches[index];

                              return BranchCard(
                                branch: branch,
                                onEditPressed: () {
                                  _openForm(context, branch: branch);
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
      ),
    );
  }
}

class _FeatureHeader extends StatelessWidget {
  const _FeatureHeader({
    required this.title,
    required this.subtitle,
    this.action,
  });

  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextApp(
                text: title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
              const SizedBox(height: 4),
              TextApp(
                text: subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
          ),
        ),
        ?action,
      ],
    );
  }
}

class _EmptyBranchesView extends StatelessWidget {
  const _EmptyBranchesView({required this.onAddPressed});

  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.store_outlined, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          TextApp(
            text: context.translate(LangKeys.noBranchesYet),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
          const SizedBox(height: 6),
          TextApp(
            text: context.translate(LangKeys.addYourFirstBranch),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add),
            label: TextApp(
              text: context.translate(LangKeys.addBranch),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
            const SizedBox(height: 12),
            TextApp(
              text: message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: TextApp(
                text: context.translate(LangKeys.retry),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
