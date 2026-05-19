import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/inventory_model.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';
import '../widgets/inventory_adjust_stock_bottom_sheet.dart';
import '../widgets/inventory_form_bottom_sheet.dart';
import '../widgets/inventory_table.dart';

class InventoryBody extends StatelessWidget {
  const InventoryBody({super.key});

  void _openForm(
    BuildContext context,
    InventoryLoaded state, {
    InventoryModel? item,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<InventoryCubit>(),
          child: InventoryFormBottomSheet(
            medications: state.medications,
            branches: state.branches,
            item: item,
          ),
        );
      },
    );
  }

  void _openAdjustStock(BuildContext context, InventoryModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<InventoryCubit>(),
          child: InventoryAdjustStockBottomSheet(item: item),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryCubit, InventoryState>(
      listenWhen: (previous, current) => current is InventoryFailure,
      listener: (context, state) {
        if (state is InventoryFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<InventoryCubit, InventoryState>(
        builder: (context, state) {
          if (state is InventoryLoading) {
            return const AppLoading();
          }

          if (state is InventoryFailure) {
            return _InventoryErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<InventoryCubit>().getInventoryData();
              },
            );
          }

          if (state is! InventoryLoaded) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppPageHeader(
                title: context.translate(LangKeys.inventory),
                subtitle: context.translate(
                  LangKeys.trackStockLevelsAcrossBranches,
                ),
                action: AppPrimaryButton(
                  text: context.translate(LangKeys.addStock),
                  icon: Icons.add,
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          _openForm(context, state);
                        },
                ),
              ),
              SizedBox(height: 14.h),
              LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth >= 700;

                  if (wide) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: context.translate(
                                LangKeys.searchInventory,
                              ),
                            ),
                            onChanged: context
                                .read<InventoryCubit>()
                                .updateSearchQuery,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        SizedBox(
                          width: 220.w,
                          child: _BranchDropdown(
                            selectedBranchId: state.selectedBranchId,
                            branches: state.branches,
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: context.translate(LangKeys.searchInventory),
                        ),
                        onChanged: context
                            .read<InventoryCubit>()
                            .updateSearchQuery,
                      ),
                      SizedBox(height: 12.h),
                      _BranchDropdown(
                        selectedBranchId: state.selectedBranchId,
                        branches: state.branches,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: state.inventory.isEmpty
                    ? AppEmptyState(
                        title: context.translate(LangKeys.noInventoryFound),
                        message:
                            state.searchQuery.trim().isEmpty &&
                                state.selectedBranchId == 'all'
                            ? context.translate(
                                LangKeys.addYourFirstInventoryItem,
                              )
                            : context.translate(
                                LangKeys.noInventoryItemsMatchYourFilters,
                              ),
                        icon: Icons.inventory_2_outlined,
                      )
                    : InventoryTable(
                        items: state.inventory,
                        isSubmitting: state.isSubmitting,
                        onTap: (item) {
                          _openForm(context, state, item: item);
                        },
                        onAdjustStock: (item) {
                          _openAdjustStock(context, item);
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

class _BranchDropdown extends StatelessWidget {
  const _BranchDropdown({
    required this.selectedBranchId,
    required this.branches,
  });

  final String selectedBranchId;
  final List<dynamic> branches;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedBranchId,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.branch),
      ),
      items: [
        DropdownMenuItem<String>(
          value: 'all',
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
        context.read<InventoryCubit>().updateSelectedBranch(value ?? 'all');
      },
    );
  }
}

class _InventoryErrorView extends StatelessWidget {
  const _InventoryErrorView({required this.message, required this.onRetry});

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
