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
import '../cubit/sales_cubit.dart';
import '../cubit/sales_state.dart';
import '../widgets/sale_form_bottom_sheet.dart';
import '../widgets/sales_table.dart';

class SalesBody extends StatelessWidget {
  const SalesBody({super.key});

  void _openSaleForm(BuildContext context, SalesLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SalesCubit>(),
          child: SaleFormBottomSheet(
            medications: state.medications,
            branches: state.branches,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalesCubit, SalesState>(
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

          return Column(
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
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: context.translate(LangKeys.searchSales),
                ),
                onChanged: context.read<SalesCubit>().updateSearchQuery,
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: state.sales.isEmpty
                    ? AppEmptyState(
                        title: context.translate(LangKeys.noSalesFound),
                        message: state.searchQuery.trim().isEmpty
                            ? context.translate(LangKeys.createYourFirstSale)
                            : context.translate(
                                LangKeys.noSalesMatchYourSearch,
                              ),
                        icon: Icons.point_of_sale_outlined,
                      )
                    : SalesTable(sales: state.sales),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SalesErrorView extends StatelessWidget {
  const _SalesErrorView({required this.message, required this.onRetry});

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
