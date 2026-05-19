import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/inventory_alerts_cubit.dart';
import '../refactor/inventory_alerts_body.dart';

class InventoryAlertsScreen extends StatelessWidget {
  const InventoryAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InventoryAlertsCubit>()..getInventoryAlerts(),
      child: const InventoryAlertsBody(),
    );
  }
}
