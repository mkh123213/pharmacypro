part of 'purchase_order_form_bottom_sheet.dart';

class _PurchaseOrderFormBottomSheetState
    extends State<PurchaseOrderFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  String? supplierId;
  String? branchId;

  final orderDate = TextEditingController();
  final expectedDelivery = TextEditingController();
  final notes = TextEditingController();

  final items = <PurchaseOrderItemModel>[];

  bool _isSaving = false;

  bool get _isEditing => widget.order != null;

  bool get _canEdit {
    return widget.order == null || widget.order!.status == 'draft';
  }

  double get total {
    return items.fold<double>(0, (sum, item) => sum + item.total);
  }

  @override
  void initState() {
    super.initState();

    final order = widget.order;

    supplierId = order?.supplierId;
    branchId = order?.branchId;
    orderDate.text = order?.orderDate ?? '';
    expectedDelivery.text = order?.expectedDelivery ?? '';
    notes.text = order?.notes ?? '';
    items.addAll(order?.items ?? []);
  }

  @override
  void dispose() {
    orderDate.dispose();
    expectedDelivery.dispose();
    notes.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.92,
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: context.color.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  ...this._buildPurchaseOrderFormBottomSheetFields1(context),
                  ...this._buildPurchaseOrderFormBottomSheetFields2(context),
                  ...this._buildPurchaseOrderFormBottomSheetFields3(context),
                  ...this._buildPurchaseOrderFormBottomSheetFields4(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
