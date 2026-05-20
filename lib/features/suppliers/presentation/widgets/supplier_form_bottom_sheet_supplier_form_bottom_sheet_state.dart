part of 'supplier_form_bottom_sheet.dart';

class _SupplierFormBottomSheetState extends State<SupplierFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController contact;
  late final TextEditingController phone;
  late final TextEditingController email;
  late final TextEditingController address;
  late final TextEditingController paymentTerms;
  late final TextEditingController notes;

  late bool isActive;
  bool _isSaving = false;

  bool get _isEditing => widget.supplier != null;

  @override
  void initState() {
    super.initState();

    final supplier = widget.supplier;

    name = TextEditingController(text: supplier?.name ?? '');
    contact = TextEditingController(text: supplier?.contactPerson ?? '');
    phone = TextEditingController(text: supplier?.phone ?? '');
    email = TextEditingController(text: supplier?.email ?? '');
    address = TextEditingController(text: supplier?.address ?? '');
    paymentTerms = TextEditingController(text: supplier?.paymentTerms ?? '');
    notes = TextEditingController(text: supplier?.notes ?? '');
    isActive = supplier?.isActive ?? true;
  }

  @override
  void dispose() {
    name.dispose();
    contact.dispose();
    phone.dispose();
    email.dispose();
    address.dispose();
    paymentTerms.dispose();
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
                  ...this._buildSupplierFormBottomSheetFields1(context),
                  ...this._buildSupplierFormBottomSheetFields2(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
