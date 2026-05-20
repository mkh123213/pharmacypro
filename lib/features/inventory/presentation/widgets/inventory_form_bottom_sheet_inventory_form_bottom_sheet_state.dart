part of 'inventory_form_bottom_sheet.dart';

class _InventoryFormBottomSheetState extends State<InventoryFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  String? medicationId;
  String? branchId;

  late final TextEditingController quantity;
  late final TextEditingController min;
  late final TextEditingController batch;
  late final TextEditingController expiry;
  late final TextEditingController location;

  bool _isSaving = false;

  bool get _isEditing => widget.item != null;

  List<MedicationModel> get activeMedications {
    return widget.medications
        .where((medication) => medication.isActive)
        .toList();
  }

  List<BranchModel> get activeBranches {
    return widget.branches.where((branch) => branch.isActive).toList();
  }

  @override
  void initState() {
    super.initState();

    medicationId =
        widget.item?.medicationId ??
        (activeMedications.isNotEmpty ? activeMedications.first.id : null);

    branchId =
        widget.item?.branchId ??
        (activeBranches.isNotEmpty ? activeBranches.first.id : null);

    quantity = TextEditingController(
      text: widget.item?.quantity.toString() ?? '0',
    );
    min = TextEditingController(
      text: widget.item?.minStockLevel.toString() ?? '10',
    );
    batch = TextEditingController(text: widget.item?.batchNumber ?? '');
    expiry = TextEditingController(text: widget.item?.expiryDate ?? '');
    location = TextEditingController(text: widget.item?.locationInStore ?? '');
  }

  @override
  void dispose() {
    quantity.dispose();
    min.dispose();
    batch.dispose();
    expiry.dispose();
    location.dispose();
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
                  ...this._buildInventoryFormBottomSheetFields1(context),
                  ...this._buildInventoryFormBottomSheetFields2(context),
                  ...this._buildInventoryFormBottomSheetFields3(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
