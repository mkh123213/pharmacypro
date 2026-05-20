part of 'sale_form_bottom_sheet.dart';

class _SaleFormBottomSheetState extends State<SaleFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  String? branchId;
  String payment = 'cash';

  final customer = TextEditingController();
  final phone = TextEditingController();
  final discount = TextEditingController();

  final items = <SaleItemModel>[];

  bool _isSaving = false;

  List<BranchModel> get activeBranches {
    return widget.branches.where((branch) => branch.isActive).toList();
  }

  List<MedicationModel> get activeMedications {
    return widget.medications
        .where((medication) => medication.isActive)
        .toList();
  }

  double get subtotal {
    return items.fold<double>(0, (sum, item) => sum + item.total);
  }

  double get discountAmount {
    return double.tryParse(discount.text.trim()) ?? 0;
  }

  double get total {
    final value = subtotal - discountAmount;
    return value < 0 ? 0 : value;
  }

  @override
  void dispose() {
    customer.dispose();
    phone.dispose();
    discount.dispose();
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
                  ...this._buildSaleFormBottomSheetFields1(context),
                  ...this._buildSaleFormBottomSheetFields2(context),
                  ...this._buildSaleFormBottomSheetFields3(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
