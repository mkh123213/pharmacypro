import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/customer_orders_cubit.dart';
import '../refactor/customer_orders_body.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CustomerOrdersCubit>()..getCustomerOrdersData(),
      child: const CustomerOrdersBody(),
    );
  }
}
