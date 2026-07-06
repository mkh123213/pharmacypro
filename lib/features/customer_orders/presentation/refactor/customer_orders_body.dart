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
import '../../../branches/data/models/branch_model.dart';
import '../cubit/customer_orders_cubit.dart';
import '../cubit/customer_orders_state.dart';
import '../widgets/customer_order_card.dart';
import '../widgets/customer_order_form_bottom_sheet.dart';
import 'customer_orders_constants.dart';

part 'customer_orders_body_branch_dropdown.dart';
part 'customer_orders_body_build_customer_order_error_message.dart';
part 'customer_orders_body_customer_order_filters.dart';
part 'customer_orders_body_customer_orders_error_view.dart';
part 'customer_orders_body_open_form.dart';
part 'customer_orders_body_status_dropdown.dart';
part 'customer_orders_body_update_order_status.dart';

class CustomerOrdersBody extends StatelessWidget {
  const CustomerOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerOrdersCubit, CustomerOrdersState>(
      listenWhen: (previous, current) => current is CustomerOrdersFailure,
      listener: (context, state) {
        if (state is CustomerOrdersFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<CustomerOrdersCubit, CustomerOrdersState>(
        builder: (context, state) {
          if (state is CustomerOrdersLoading) {
            return const AppLoading();
          }

          if (state is CustomerOrdersFailure) {
            return _CustomerOrdersErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<CustomerOrdersCubit>().getCustomerOrdersData();
              },
            );
          }

          if (state is! CustomerOrdersLoaded) {
            return const SizedBox.shrink();
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (state.hasMore &&
                  !state.isLoadingMore &&
                  notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent - 200) {
                context.read<CustomerOrdersCubit>().loadMoreCustomerOrders();
              }
              return false;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppPageHeader(
                    title: context.translate(LangKeys.customerOrders),
                    subtitle: context.translate(
                      LangKeys.browseAndManageCustomerOrders,
                    ),
                    action: AppPrimaryButton(
                      text: context.translate(LangKeys.newOrder),
                      icon: Icons.add,
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              _openForm(context, state);
                            },
                    ),
                  ),
                  SizedBox(height: 14.h),
                  _CustomerOrderFilters(state: state),
                  SizedBox(height: 14.h),
                  if (state.errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: TextApp(
                        text: _buildCustomerOrderErrorMessage(
                          context,
                          state.errorMessage!,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle.copyWith(color: Colors.red),
                      ),
                    ),
                  state.orders.isEmpty
                      ? AppEmptyState(
                          title: context.translate(LangKeys.noOrdersFound),
                          message:
                              state.searchQuery.trim().isEmpty &&
                                  state.selectedStatus ==
                                      allCustomerOrderStatusesValue &&
                                  state.selectedBranchId == 'all'
                              ? context.translate(LangKeys.createYourFirstOrder)
                              : context.translate(
                                  LangKeys.noOrdersMatchYourFilters,
                                ),
                          imagePath: context.assets.noOrdersFound,
                        )
                      : ListView.separated(
                          itemCount: state.orders.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, _) => SizedBox(height: 8.h),
                          itemBuilder: (_, index) {
                            final order = state.orders[index];
                            final nextStatus =
                                nextCustomerOrderStatus[order.status];

                            return CustomerOrderCard(
                              order: order,
                              onNextStatus:
                                  nextStatus == null || state.isSubmitting
                                  ? null
                                  : () {
                                      _updateOrderStatus(
                                        context: context,
                                        orderId: order.id,
                                        nextStatus: nextStatus,
                                      );
                                    },
                              onDelete: state.isSubmitting
                                  ? null
                                  : () async {
                                      final confirmed =
                                          await showDeleteConfirmationDialog(
                                            context: context,
                                            title: context.translate(
                                              LangKeys.deleteCustomerOrder,
                                            ),
                                            message: context.translate(
                                              LangKeys
                                                  .deleteCustomerOrderConfirmation,
                                            ),
                                          );

                                      if (confirmed != true || !context.mounted)
                                        return;

                                      final success = await context
                                          .read<CustomerOrdersCubit>()
                                          .deleteCustomerOrder(order.id);

                                      if (!context.mounted) return;

                                      if (success) {
                                        ShowToast.showToastSuccessTop(
                                          message: context.translate(
                                            LangKeys
                                                .customerOrderDeletedSuccessfully,
                                          ),
                                        );
                                      }
                                    },
                            );
                          },
                        ),
                  if (state.isLoadingMore)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
