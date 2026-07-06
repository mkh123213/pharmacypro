import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/common/widgets/app_image_asset_previewer.dart';
import 'package:pharmacypro/core/common/widgets/app_search_icon.dart';
import 'package:pharmacypro/core/di/dependency_injection.dart';

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
import '../../data/models/purchase_order_model.dart';
import '../cubit/purchase_orders_cubit.dart';
import '../cubit/purchase_orders_state.dart';
import '../widgets/purchase_order_details_bottom_sheet.dart';
import '../widgets/purchase_order_form_bottom_sheet.dart';
import '../widgets/purchase_orders_table.dart';
import 'purchase_orders_constants.dart';

part 'purchase_orders_body_branch_dropdown.dart';
part 'purchase_orders_body_build_purchase_order_error_message.dart';
part 'purchase_orders_body_confirm_cancel_purchase_order.dart';
part 'purchase_orders_body_confirm_receive_purchase_order.dart';
part 'purchase_orders_body_content_1.dart';
part 'purchase_orders_body_content_2.dart';
part 'purchase_orders_body_open_form.dart';
part 'purchase_orders_body_purchase_order_filters.dart';
part 'purchase_orders_body_purchase_order_summary_card.dart';
part 'purchase_orders_body_purchase_order_summary_card_data.dart';
part 'purchase_orders_body_purchase_order_summary_cards.dart';
part 'purchase_orders_body_purchase_orders_error_view.dart';
part 'purchase_orders_body_status_dropdown.dart';
part 'purchase_orders_body_update_purchase_order_status.dart';

class PurchaseOrdersBody extends StatelessWidget {
  const PurchaseOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchaseOrdersCubit, PurchaseOrdersState>(
      listenWhen: (previous, current) => current is PurchaseOrdersFailure,
      listener: (context, state) {
        if (state is PurchaseOrdersFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<PurchaseOrdersCubit, PurchaseOrdersState>(
        builder: (context, state) {
          if (state is PurchaseOrdersLoading) {
            return const AppLoading();
          }

          if (state is PurchaseOrdersFailure) {
            return _PurchaseOrdersErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<PurchaseOrdersCubit>().getPurchaseOrdersData();
              },
            );
          }

          if (state is! PurchaseOrdersLoaded) {
            return const SizedBox.shrink();
          }

          return RefreshIndicator(
            onRefresh: context
                .read<PurchaseOrdersCubit>()
                .getPurchaseOrdersData,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (state.hasMore &&
                    !state.isLoadingMore &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 200) {
                  context.read<PurchaseOrdersCubit>().loadMorePurchaseOrders();
                }
                return false;
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildPurchaseOrdersContent1(context, state),
                    ..._buildPurchaseOrdersContent2(context, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
