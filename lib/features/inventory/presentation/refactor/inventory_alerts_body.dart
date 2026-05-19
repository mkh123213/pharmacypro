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
import '../cubit/inventory_alerts_cubit.dart';
import '../cubit/inventory_alerts_state.dart';
import '../widgets/inventory_alert_card.dart';
import '../widgets/inventory_alert_filter_bar.dart';
import '../widgets/inventory_alerts_table.dart';

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
                  onPressed: () {
                    context.read<InventoryAlertsCubit>().getInventoryAlerts();
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
                            );
                          }

                          return ListView.separated(
                            itemCount: state.filteredAlerts.length,
                            separatorBuilder: (_, _) => SizedBox(height: 8.h),
                            itemBuilder: (context, index) {
                              return InventoryAlertCard(
                                alert: state.filteredAlerts[index],
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

class _AlertsSummary extends StatelessWidget {
  const _AlertsSummary({required this.alertsCount});

  final int alertsCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber,
              size: 26.sp,
              color: alertsCount > 0 ? Colors.orange : Colors.green,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextApp(
                text: alertsCount > 0
                    ? context
                          .translate(LangKeys.inventoryAlertsCount)
                          .replaceAll('{count}', alertsCount.toString())
                    : context.translate(LangKeys.noActiveInventoryAlerts),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InventoryAlertsErrorView extends StatelessWidget {
  const _InventoryAlertsErrorView({
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
