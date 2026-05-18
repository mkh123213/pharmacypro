import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacypro/core/extensions/context_extension.dart';
import 'package:pharmacypro/core/language/lang_keys.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../data/models/supplier_model.dart';
import '../cubit/suppliers_cubit.dart';
import '../cubit/suppliers_state.dart';
import '../widgets/supplier_card.dart';
import '../widgets/supplier_form_bottom_sheet.dart';

class SuppliersBody extends StatelessWidget {
  const SuppliersBody({super.key});

  void _openForm(BuildContext context, {SupplierModel? supplier}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SuppliersCubit>(),
          child: SupplierFormBottomSheet(supplier: supplier),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SuppliersCubit, SuppliersState>(
      listenWhen: (previous, current) => current is SuppliersFailure,
      listener: (context, state) {
        if (state is SuppliersFailure) {
          ShowToast.showToastErrorTop(
            message: context.translate(state.message),
          );
        }
      },
      child: BlocBuilder<SuppliersCubit, SuppliersState>(
        builder: (context, state) {
          if (state is SuppliersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SuppliersFailure) {
            return _ErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<SuppliersCubit>().getSuppliers();
              },
            );
          }

          if (state is! SuppliersLoaded) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FeatureHeader(
                title: context.translate(LangKeys.suppliers),
                subtitle: context.translate(LangKeys.manageMedicationSuppliers),
                action: ElevatedButton.icon(
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          _openForm(context);
                        },
                  icon: const Icon(Icons.add),
                  label: TextApp(
                    text: context.translate(LangKeys.addSupplier),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: context.translate(LangKeys.searchSuppliers),
                ),
                onChanged: context.read<SuppliersCubit>().updateSearchQuery,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.suppliers.isEmpty
                    ? _EmptySuppliersView(
                        hasSearch: state.searchQuery.trim().isNotEmpty,
                        onAddPressed: () {
                          _openForm(context);
                        },
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final count = constraints.maxWidth >= 1000
                              ? 3
                              : constraints.maxWidth >= 650
                              ? 2
                              : 1;

                          return GridView.builder(
                            itemCount: state.suppliers.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: count,
                                  crossAxisSpacing: 14,
                                  mainAxisSpacing: 14,
                                  childAspectRatio: count == 1 ? 1.6 : 1.2,
                                ),
                            itemBuilder: (_, index) {
                              final supplier = state.suppliers[index];

                              return SupplierCard(
                                supplier: supplier,
                                onEditPressed: () {
                                  _openForm(context, supplier: supplier);
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
      ),
    );
  }
}

class _FeatureHeader extends StatelessWidget {
  const _FeatureHeader({
    required this.title,
    required this.subtitle,
    this.action,
  });

  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextApp(
                text: title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
              const SizedBox(height: 4),
              TextApp(
                text: subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ],
          ),
        ),
        ?action,
      ],
    );
  }
}

class _EmptySuppliersView extends StatelessWidget {
  const _EmptySuppliersView({
    required this.hasSearch,
    required this.onAddPressed,
  });

  final bool hasSearch;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    if (hasSearch) {
      return Center(
        child: TextApp(
          text: context.translate(LangKeys.noSuppliersFound),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          theme: context.textStyle,
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_shipping_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          TextApp(
            text: context.translate(LangKeys.noSuppliersYet),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
          const SizedBox(height: 6),
          TextApp(
            text: context.translate(LangKeys.addYourFirstSupplier),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            theme: context.textStyle,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add),
            label: TextApp(
              text: context.translate(LangKeys.addSupplier),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
            const SizedBox(height: 12),
            TextApp(
              text: message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: TextApp(
                text: context.translate(LangKeys.retry),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
