import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../cubit/sales_cubit.dart';
import '../cubit/sales_state.dart';
import '../widgets/sale_form_bottom_sheet.dart';
import '../widgets/sales_table.dart';

part 'sales_body_build_sale_error_message.dart';
part 'sales_body_open_sale_form.dart';
part 'sales_body_payment_method_dropdown.dart';
part 'sales_body_sales_error_view.dart';
part 'sales_body_sales_filters.dart';

class SalesBody extends StatelessWidget {
  const SalesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyN, control: true): () {
          final state = context.read<SalesCubit>().state;
          if (state is SalesLoaded && !state.isSubmitting) {
            _openSaleForm(context, state);
          }
        },
        const SingleActivator(LogicalKeyboardKey.f5): () {
          context.read<SalesCubit>().getSalesData();
        },
      },
      child: Focus(
        autofocus: true,
        child: BlocListener<SalesCubit, SalesState>(
          listenWhen: (previous, current) => current is SalesFailure,
          listener: (context, state) {
            if (state is SalesFailure) {
              ShowToast.showToastErrorTop(
                message: context.translate(state.message),
              );
            }
          },
          child: BlocBuilder<SalesCubit, SalesState>(
            builder: (context, state) {
              if (state is SalesLoading) {
                return const AppLoading();
              }

              if (state is SalesFailure) {
                return _SalesErrorView(
                  message: context.translate(state.message),
                  onRetry: () {
                    context.read<SalesCubit>().getSalesData();
                  },
                );
              }

              if (state is! SalesLoaded) {
                return const SizedBox.shrink();
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (state.hasMore &&
                      !state.isLoadingMore &&
                      notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent - 200) {
                    context.read<SalesCubit>().loadMoreSales();
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppPageHeader(
                        title: context.translate(LangKeys.salesAndPos),
                        subtitle: context.translate(
                          LangKeys.processSalesAndViewTransactionHistory,
                        ),
                        action: AppPrimaryButton(
                          text: context.translate(LangKeys.newSale),
                          icon: Icons.add,
                          onPressed: state.isSubmitting
                              ? null
                              : () {
                                  _openSaleForm(context, state);
                                },
                        ),
                      ),
                      SizedBox(height: 14.h),
                      _SalesFilters(state: state),
                      SizedBox(height: 14.h),
                      if (state.errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: TextApp(
                            text: _buildSaleErrorMessage(
                              context,
                              state.errorMessage!,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      state.sales.isEmpty
                          ? AppEmptyState(
                              title: context.translate(LangKeys.noSalesFound),
                              message:
                                  state.searchQuery.trim().isEmpty &&
                                      state.selectedPaymentMethod == 'all'
                                  ? context.translate(
                                      LangKeys.createYourFirstSale,
                                    )
                                  : context.translate(
                                      LangKeys.noSalesMatchYourSearch,
                                    ),
                              imagePath: context.assets.noSalesFound,
                            )
                          : SalesTable(
                              sales: state.sales,
                              onDelete: (sale) async {
                                final confirmed =
                                    await showDeleteConfirmationDialog(
                                      context: context,
                                      title: context.translate(
                                        LangKeys.deleteSale,
                                      ),
                                      message: context.translate(
                                        LangKeys.deleteSaleConfirmation,
                                      ),
                                    );

                                if (confirmed != true || !context.mounted)
                                  return;

                                final success = await context
                                    .read<SalesCubit>()
                                    .deleteSale(sale.id);

                                if (!context.mounted) return;

                                if (success) {
                                  ShowToast.showToastSuccessTop(
                                    message: context.translate(
                                      LangKeys.saleDeletedSuccessfully,
                                    ),
                                  );
                                }
                              },
                            ),
                      if (state.isLoadingMore)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

const paymentMethods = ['cash', 'card', 'insurance', 'online'];

String paymentMethodLabel(BuildContext context, String value) {
  switch (value) {
    case 'cash':
      return context.translate(LangKeys.cash);
    case 'card':
      return context.translate(LangKeys.card);
    case 'insurance':
      return context.translate(LangKeys.insurance);
    case 'online':
      return context.translate(LangKeys.online);
    default:
      return value;
  }
}
