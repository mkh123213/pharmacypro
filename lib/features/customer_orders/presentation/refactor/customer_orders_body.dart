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
import '../cubit/customer_orders_cubit.dart';
import '../cubit/customer_orders_state.dart';
import '../widgets/customer_order_card.dart';
import '../widgets/customer_order_form_bottom_sheet.dart';
import 'customer_orders_constants.dart';

class CustomerOrdersBody extends StatelessWidget {
  const CustomerOrdersBody({super.key});

  void _openForm(BuildContext context, CustomerOrdersLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<CustomerOrdersCubit>(),
          child: CustomerOrderFormBottomSheet(
            medications: state.medications,
            branches: state.branches,
          ),
        );
      },
    );
  }

  Future<void> _updateOrderStatus({
    required BuildContext context,
    required String orderId,
    required String nextStatus,
  }) async {
    final success = await context.read<CustomerOrdersCubit>().updateStatus(
      orderId,
      nextStatus,
    );

    if (!context.mounted) return;

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotUpdateOrderStatus),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.orderStatusUpdatedSuccessfully),
    );
  }

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

          return Column(
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
                                LangKeys.searchOrders,
                              ),
                            ),
                            onChanged: context
                                .read<CustomerOrdersCubit>()
                                .updateSearchQuery,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        SizedBox(
                          width: 220.w,
                          child: _StatusDropdown(
                            selectedStatus: state.selectedStatus,
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
                          hintText: context.translate(LangKeys.searchOrders),
                        ),
                        onChanged: context
                            .read<CustomerOrdersCubit>()
                            .updateSearchQuery,
                      ),
                      SizedBox(height: 12.h),
                      _StatusDropdown(selectedStatus: state.selectedStatus),
                    ],
                  );
                },
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: state.orders.isEmpty
                    ? AppEmptyState(
                        title: context.translate(LangKeys.noOrdersFound),
                        message:
                            state.searchQuery.trim().isEmpty &&
                                state.selectedStatus ==
                                    allCustomerOrderStatusesValue
                            ? context.translate(LangKeys.createYourFirstOrder)
                            : context.translate(
                                LangKeys.noOrdersMatchYourFilters,
                              ),
                        icon: Icons.shopping_bag_outlined,
                      )
                    : ListView.separated(
                        itemCount: state.orders.length,
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

class _StatusDropdown extends StatelessWidget {
  const _StatusDropdown({required this.selectedStatus});

  final String selectedStatus;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedStatus,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.status),
      ),
      items: customerOrderStatuses.map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: TextApp(
            text: customerOrderStatusLabel(context, status),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        );
      }).toList(),
      onChanged: (value) {
        context.read<CustomerOrdersCubit>().updateSelectedStatus(
          value ?? allCustomerOrderStatusesValue,
        );
      },
    );
  }
}

class _CustomerOrdersErrorView extends StatelessWidget {
  const _CustomerOrdersErrorView({
    required this.message,
    required this.onRetry,
  });

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
