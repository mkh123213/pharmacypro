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
import '../cubit/stock_movements_cubit.dart';
import '../cubit/stock_movements_state.dart';
import '../widgets/stock_movement_card.dart';
import '../widgets/stock_movement_filter_bar.dart';
import '../widgets/stock_movements_table.dart';

part 'stock_movements_body_stock_movements_error_view.dart';

class StockMovementsBody extends StatelessWidget {
  const StockMovementsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<StockMovementsCubit, StockMovementsState>(
      listenWhen: (previous, current) => current is StockMovementsFailure,
      listener: (context, state) {
        if (state is StockMovementsFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<StockMovementsCubit, StockMovementsState>(
        builder: (context, state) {
          if (state is StockMovementsLoading) {
            return const AppLoading();
          }

          if (state is StockMovementsFailure) {
            return _StockMovementsErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<StockMovementsCubit>().getStockMovements();
              },
            );
          }

          if (state is! StockMovementsLoaded) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppPageHeader(
                title: context.translate(LangKeys.stockHistory),
                subtitle: context.translate(LangKeys.trackAllStockMovements),
                action: AppPrimaryButton(
                  text: context.translate(LangKeys.refresh),
                  icon: Icons.refresh,
                  onPressed: () {
                    context.read<StockMovementsCubit>().getStockMovements();
                  },
                ),
              ),
              SizedBox(height: 14.h),
              StockMovementFilterBar(
                selectedType: state.selectedType,
                onSearchChanged: context
                    .read<StockMovementsCubit>()
                    .updateSearchQuery,
                onTypeChanged: context
                    .read<StockMovementsCubit>()
                    .updateSelectedType,
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: state.filteredMovements.isEmpty
                    ? AppEmptyState(
                        title: context.translate(
                          LangKeys.noStockMovementsFound,
                        ),
                        message: context.translate(
                          LangKeys.noStockMovementsMatchYourFilters,
                        ),
                        imagePath: context.assets.noStockMovementsFound,
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth >= 800) {
                            return StockMovementsTable(
                              movements: state.filteredMovements,
                            );
                          }

                          return ListView.separated(
                            itemCount: state.filteredMovements.length,
                            separatorBuilder: (_, _) => SizedBox(height: 8.h),
                            itemBuilder: (context, index) {
                              return StockMovementCard(
                                movement: state.filteredMovements[index],
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
