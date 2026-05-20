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
import '../../data/models/inventory_alert_model.dart';
import '../cubit/inventory_alerts_cubit.dart';
import '../cubit/inventory_alerts_state.dart';
import '../widgets/inventory_alert_card.dart';
import '../widgets/inventory_alert_filter_bar.dart';
import '../widgets/inventory_alerts_table.dart';
import '../widgets/remove_expired_stock_bottom_sheet.dart';

part 'inventory_alerts_body_alerts_summary.dart';
part 'inventory_alerts_body_inventory_alerts_error_view.dart';

part 'inventory_alerts_body_open_remove_expired_stock_sheet.dart';
class InventoryAlertsBody extends StatelessWidget {
  const InventoryAlertsBody({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryAlertsCubit, InventoryAlertsState>(
      listenWhen: (previous, current) => current is InventoryAlertsFailure,
      listener: (context, state) {
        if (state is InventoryAlertsFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<InventoryAlertsCubit, InventoryAlertsState>(
        builder: (context, state) {
          if (state is InventoryAlertsLoading) {
            return const AppLoading();
          }

          if (state is InventoryAlertsFailure) {
            return _InventoryAlertsErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<InventoryAlertsCubit>().getInventoryAlerts();
              },
            );
          }

          if (state is! InventoryAlertsLoaded) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppPageHeader(
                title: context.translate(LangKeys.inventoryAlerts),
                subtitle: context.translate(
                  LangKeys.monitorLowStockAndExpiryAlerts,
                ),
                action: AppPrimaryButton(
                  text: context.translate(LangKeys.refresh),
                  icon: Icons.refresh,
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          context
                              .read<InventoryAlertsCubit>()
                              .getInventoryAlerts();
                        },
                ),
              ),
              SizedBox(height: 14.h),
              _AlertsSummary(alertsCount: state.alerts.length),
              SizedBox(height: 14.h),
              InventoryAlertFilterBar(
                selectedType: state.selectedType,
                onSearchChanged: context
                    .read<InventoryAlertsCubit>()
                    .updateSearchQuery,
                onTypeChanged: context
                    .read<InventoryAlertsCubit>()
                    .updateSelectedType,
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: state.filteredAlerts.isEmpty
                    ? AppEmptyState(
                        title: context.translate(
                          LangKeys.noInventoryAlertsFound,
                        ),
                        message: context.translate(
                          LangKeys.allInventoryLooksHealthy,
                        ),
                        icon: Icons.notifications_none_outlined,
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth >= 850) {
                            return InventoryAlertsTable(
                              alerts: state.filteredAlerts,
                              onRemoveExpiredStock: (alert) {
                                this._openRemoveExpiredStockSheet(context, alert);
                              },
                            );
                          }

                          return ListView.separated(
                            itemCount: state.filteredAlerts.length,
                            separatorBuilder: (_, _) => SizedBox(height: 8.h),
                            itemBuilder: (context, index) {
                              final alert = state.filteredAlerts[index];

                              return InventoryAlertCard(
                                alert: alert,
                                onRemoveExpiredStock: alert.type == 'expired'
                                    ? () {
                                        this._openRemoveExpiredStockSheet(
                                          context,
                                          alert,
                                        );
                                      }
                                    : null,
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
