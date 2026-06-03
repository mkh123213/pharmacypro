import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/purchase_orders_cubit.dart';
import '../refactor/purchase_orders_body.dart';

class PurchaseOrdersScreen extends StatelessWidget {
  const PurchaseOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PurchaseOrdersCubit>()..getPurchaseOrdersData(),
      child: const PurchaseOrdersBody(),
    );
  }
}
