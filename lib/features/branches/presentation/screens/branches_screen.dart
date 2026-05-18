import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/../../core/di/dependency_injection.dart';
import '../cubit/branches_cubit.dart';
import '../refactor/branches_body.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BranchesCubit>()..getBranches(),
      child: const BranchesBody(),
    );
  }
}
