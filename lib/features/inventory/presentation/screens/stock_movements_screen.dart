import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/stock_movements_cubit.dart';
import '../refactor/stock_movements_body.dart';

class StockMovementsScreen extends StatelessWidget {
  const StockMovementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<StockMovementsCubit>()..getStockMovements(),
      child: const StockMovementsBody(),
    );
  }
}
