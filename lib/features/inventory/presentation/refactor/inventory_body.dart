import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../data/models/inventory_model.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';
import '../widgets/inventory_adjust_stock_bottom_sheet.dart';
import '../widgets/inventory_form_bottom_sheet.dart';
import '../widgets/inventory_table.dart';

part 'inventory_body_branch_dropdown.dart';
part 'inventory_body_inventory_error_view.dart';
part 'inventory_body_inventory_filters.dart';
part 'inventory_body_inventory_header_actions.dart';
part 'inventory_body_stock_status_dropdown.dart';

part 'inventory_body_build_inventory_error_message.dart';
part 'inventory_body_open_adjust_stock.dart';
part 'inventory_body_open_form.dart';
class InventoryBody extends StatelessWidget {
  const InventoryBody({super.key});




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

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPageHeader(
                  title: context.translate(LangKeys.inventory),
                  subtitle: context.translate(
                    LangKeys.trackStockLevelsAcrossBranches,
                  ),
                  action: _InventoryHeaderActions(
                    isSubmitting: state.isSubmitting,
                    onAddStock: () {
                      this._openForm(context, state);
                    },
                  ),
                ),
                SizedBox(height: 14.h),
                _InventoryFilters(state: state),
                SizedBox(height: 14.h),
                if (state.errorMessage != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: TextApp(
                      text: this._buildInventoryErrorMessage(
                        context,
                        state.errorMessage!,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(color: Colors.red),
                    ),
                  ),
                state.inventory.isEmpty
                    ? AppEmptyState(
                        title: context.translate(LangKeys.noInventoryFound),
                        message:
                            state.searchQuery.trim().isEmpty &&
                                state.selectedBranchId == 'all' &&
                                state.selectedStockStatus == 'all'
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
                          this._openForm(context, state, item: item);
                        },
                        onAdjustStock: (item) {
                          this._openAdjustStock(context, item);
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
