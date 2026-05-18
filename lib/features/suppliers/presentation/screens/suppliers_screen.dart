import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/suppliers_cubit.dart';
import '../refactor/suppliers_body.dart';

class SuppliersScreen extends StatelessWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SuppliersCubit>()..getSuppliers(),
      child: const SuppliersBody(),
    );
  }
}
