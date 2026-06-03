import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/prescriptions_cubit.dart';
import '../refactor/prescriptions_body.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PrescriptionsCubit>()..getPrescriptionsData(),
      child: const PrescriptionsBody(),
    );
  }
}
