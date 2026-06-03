part of 'customer_order_form_bottom_sheet.dart';

class _CustomerOrderFormBottomSheetState
    extends State<CustomerOrderFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  String orderType = 'pickup';
  String paymentMethod = 'cash';
  String? branchId;

  final items = <CustomerOrderItemModel>[];

  bool _isSaving = false;

  List<BranchModel> get activeBranches {
    return widget.branches.where((branch) => branch.isActive).toList();
  }

  List<MedicationModel> get activeMedications {
    return widget.medications
        .where((medication) => medication.isActive)
        .toList();
  }

  double get total {
    return items.fold<double>(0, (sum, item) => sum + item.total);
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: context.color.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  ...this._buildCustomerOrderFormBottomSheetFields1(context),
                  ...this._buildCustomerOrderFormBottomSheetFields2(context),
                  ...this._buildCustomerOrderFormBottomSheetFields3(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
