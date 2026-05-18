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
import '../../data/models/medication_model.dart';
import '../cubit/medications_cubit.dart' hide allMedicationCategoriesValue;
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
      builder: (_) {
        return BlocProvider.value(
          value: context.read<MedicationsCubit>(),
          child: MedicationFormBottomSheet(medication: medication),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicationsCubit, MedicationsState>(
      listenWhen: (previous, current) => current is MedicationsFailure,
      listener: (context, state) {
        if (state is MedicationsFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<MedicationsCubit, MedicationsState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              return const SizedBox.shrink();
            },
            loading: () {
              return const AppLoading();
            },
            failure: (message) {
              return _MedicationsErrorView(
                message: context.translate(message),
                onRetry: () {
                  context.read<MedicationsCubit>().getMedications();
                },
              );
            },
            loaded: (medications, searchQuery, selectedCategory, isSubmitting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppPageHeader(
                    title: context.translate(LangKeys.medications),
                    subtitle: context.translate(
                      LangKeys.manageMedicationCatalog,
                    ),
                    action: AppPrimaryButton(
                      text: context.translate(LangKeys.addMedication),
                      icon: Icons.add,
                      onPressed: isSubmitting
                          ? null
                          : () {
                              _openForm(context);
                            },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth >= 700;

                      if (wide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: context
                                    .read<MedicationsCubit>()
                                    .updateSearchQuery,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  hintText: context.translate(
                                    LangKeys.searchMedication,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            SizedBox(
                              width: 220.w,
                              child: _CategoryDropdown(
                                selectedCategory: selectedCategory,
                              ),
                            ),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          TextField(
                            onChanged: context
                                .read<MedicationsCubit>()
                                .updateSearchQuery,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: context.translate(
                                LangKeys.searchMedication,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _CategoryDropdown(selectedCategory: selectedCategory),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: medications.isEmpty
                        ? AppEmptyState(
                            title: context.translate(
                              LangKeys.noMedicationsFound,
                            ),
                            message:
                                searchQuery.trim().isEmpty &&
                                    selectedCategory ==
                                        allMedicationCategoriesValue
                                ? context.translate(
                                    LangKeys.addYourFirstMedication,
                                  )
                                : context.translate(
                                    LangKeys.noMedicationsMatchYourFilters,
                                  ),
                            icon: Icons.medication_outlined,
                          )
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              final count = constraints.maxWidth >= 1200
                                  ? 4
                                  : constraints.maxWidth >= 900
                                  ? 3
                                  : constraints.maxWidth >= 600
                                  ? 2
                                  : 1;

                              return GridView.builder(
                                itemCount: medications.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: count,
                                      crossAxisSpacing: 14.w,
                                      mainAxisSpacing: 14.h,
                                      childAspectRatio: count == 1 ? 1.55 : .90,
                                    ),
                                itemBuilder: (_, index) {
                                  final medication = medications[index];

                                  return MedicationCard(
                                    medication: medication,
                                    onEditPressed: () {
                                      _openForm(
                                        context,
                                        medication: medication,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({required this.selectedCategory});

  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedCategory,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.category),
      ),
      items: medicationCategoryOptions.map((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: TextApp(
            text: medicationCategoryLabel(context, category),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        context.read<MedicationsCubit>().updateSelectedCategory(value);
      },
    );
  }
}

class _MedicationsErrorView extends StatelessWidget {
  const _MedicationsErrorView({required this.message, required this.onRetry});

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
