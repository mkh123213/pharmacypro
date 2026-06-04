import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_delete_confirmation_dialog.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_loading.dart';
import '../../../../core/common/widgets/app_page_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/supplier_model.dart';
import '../cubit/suppliers_cubit.dart';
import '../cubit/suppliers_state.dart';
import '../widgets/supplier_card.dart';
import '../widgets/supplier_form_bottom_sheet.dart';

part 'suppliers_body_supplier_status_dropdown.dart';
part 'suppliers_body_suppliers_error_view.dart';
part 'suppliers_body_suppliers_filters.dart';
part 'suppliers_body_suppliers_grid.dart';

part 'suppliers_body_build_supplier_error_message.dart';

part 'suppliers_body_open_form.dart';
class SuppliersBody extends StatelessWidget {
  const SuppliersBody({super.key});


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
            return const AppLoading();
          }

          if (state is SuppliersFailure) {
            return _SuppliersErrorView(
              message: context.translate(state.message),
              onRetry: () {
                context.read<SuppliersCubit>().getSuppliers();
              },
            );
          }

          if (state is! SuppliersLoaded) {
            return const SizedBox.shrink();
          }

          return RefreshIndicator(
            onRefresh: context.read<SuppliersCubit>().getSuppliers,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppPageHeader(
                    title: context.translate(LangKeys.suppliers),
                    subtitle: context.translate(
                      LangKeys.manageMedicationSuppliers,
                    ),
                    action: AppPrimaryButton(
                      text: context.translate(LangKeys.addSupplier),
                      icon: Icons.add,
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              this._openForm(context);
                            },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _SuppliersFilters(state: state),
                  SizedBox(height: 20.h),
                  if (state.errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: TextApp(
                        text: buildSupplierErrorMessage(
                          context,
                          state.errorMessage!,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        theme: context.textStyle.copyWith(color: Colors.red),
                      ),
                    ),
                  state.suppliers.isEmpty
                      ? AppEmptyState(
                          title: context.translate(LangKeys.noSuppliersFound),
                          message:
                              state.searchQuery.trim().isEmpty &&
                                  state.selectedStatus == 'all'
                              ? context.translate(LangKeys.addYourFirstSupplier)
                              : context.translate(
                                  LangKeys.noSuppliersMatchYourFilters,
                                ),
                          icon: Icons.local_shipping_outlined,
                        )
                      : _SuppliersGrid(
                          suppliers: state.suppliers,
                          onEditPressed: (supplier) {
                            this._openForm(context, supplier: supplier);
                          },
                          onDeletePressed: (supplier) async {
                            final confirmed = await showDeleteConfirmationDialog(
                              context: context,
                              title: context.translate(LangKeys.deleteSupplier),
                              message: context.translate(LangKeys.deleteSupplierConfirmation),
                            );

                            if (confirmed != true || !context.mounted) return;

                            final success = await context.read<SuppliersCubit>().deleteSupplier(supplier.id);

                            if (!context.mounted) return;

                            if (success) {
                              ShowToast.showToastSuccessTop(
                                message: context.translate(LangKeys.supplierDeletedSuccessfully),
                              );
                            }
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
