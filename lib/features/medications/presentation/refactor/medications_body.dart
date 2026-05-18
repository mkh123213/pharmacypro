import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../data/models/medication_model.dart';
import '../cubit/medications_cubit.dart';
import '../cubit/medications_state.dart';
import '../widgets/medication_card.dart';
import '../widgets/medication_form_bottom_sheet.dart';
import 'medications_constants.dart';

class MedicationsBody extends StatelessWidget {
  const MedicationsBody({super.key});

  void _openForm(BuildContext context, {MedicationModel? medication}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(value: context.read<MedicationsCubit>(), child: MedicationFormBottomSheet(medication: medication)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicationsCubit, MedicationsState>(
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const AppLoading(),
        failure: (message) => Center(child: TextApp(text: message)),
        loaded: (medications, searchQuery, selectedCategory, isSubmitting) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppPageHeader(
              title: 'Medications',
              subtitle: 'Manage your medication catalog',
              action: AppPrimaryButton(text: 'Add Medication', icon: Icons.add, onPressed: () => _openForm(context)),
            ),
            SizedBox(height: 16.h),
            LayoutBuilder(builder: (context, constraints) {
              final wide = constraints.maxWidth >= 700;
              return Flex(
                direction: wide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: wide ? 1 : 0,
                    child: TextField(
                      onChanged: context.read<MedicationsCubit>().updateSearchQuery,
                      decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search by name or generic...'),
                    ),
                  ),
                  SizedBox(width: wide ? 12.w : 0, height: wide ? 0 : 12.h),
                  SizedBox(
                    width: wide ? 220.w : double.infinity,
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      items: medicationCategoryOptions.map((c) => DropdownMenuItem(value: c, child: Text(formatMedicationLabel(c)))).toList(),
                      onChanged: (v) { if (v != null) context.read<MedicationsCubit>().updateSelectedCategory(v); },
                      decoration: const InputDecoration(labelText: 'Category'),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 20.h),
            Expanded(
              child: medications.isEmpty
                ? AppEmptyState(title: 'No medications found', message: 'Add your first medication.', icon: Icons.medication_outlined)
                : LayoutBuilder(builder: (context, constraints) {
                    final count = constraints.maxWidth >= 1200 ? 4 : constraints.maxWidth >= 900 ? 3 : constraints.maxWidth >= 600 ? 2 : 1;
                    return GridView.builder(
                      itemCount: medications.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count, crossAxisSpacing: 14.w, mainAxisSpacing: 14.h, childAspectRatio: count == 1 ? 1.65 : .95),
                      itemBuilder: (_, index) => MedicationCard(medication: medications[index], onEditPressed: () => _openForm(context, medication: medications[index])),
                    );
                  }),
            ),
          ]);
        },
      ),
    );
  }
}
