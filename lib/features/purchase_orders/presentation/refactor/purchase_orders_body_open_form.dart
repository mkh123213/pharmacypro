part of 'purchase_orders_body.dart';

extension PurchaseOrdersBodyOpenForm on PurchaseOrdersBody {
void _openForm(
    BuildContext context,
    PurchaseOrdersLoaded state, {
    PurchaseOrderModel? order,
  }) {
    final activeSuppliers = state.suppliers.where((supplier) {
      return supplier.isActive;
    }).toList();

    final activeBranches = state.branches.where((branch) {
      return branch.isActive;
    }).toList();

    final activeMedications = state.medications.where((medication) {
      return medication.isActive;
    }).toList();

    if (activeSuppliers.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveSuppliersFound),
      );
      return;
    }

    if (activeBranches.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveBranchesFound),
      );
      return;
    }

    if (activeMedications.isEmpty) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.noActiveMedicationsFound),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<PurchaseOrdersCubit>(),
          child: PurchaseOrderFormBottomSheet(
            suppliers: activeSuppliers,
            branches: activeBranches,
            medications: activeMedications,
            order: order,
          ),
        );
      },
    );
  }
}
