part of 'branch_form_bottom_sheet.dart';

class _BranchFormBottomSheetState extends State<BranchFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController city;
  late final TextEditingController address;
  late final TextEditingController phone;
  late final TextEditingController email;
  late final TextEditingController manager;
  late final TextEditingController hours;

  late bool isActive;
  bool _isSaving = false;

  bool get _isEditing => widget.branch != null;

  @override
  void initState() {
    super.initState();

    final branch = widget.branch;

    name = TextEditingController(text: branch?.name ?? '');
    city = TextEditingController(text: branch?.city ?? '');
    address = TextEditingController(text: branch?.address ?? '');
    phone = TextEditingController(text: branch?.phone ?? '');
    email = TextEditingController(text: branch?.email ?? '');
    manager = TextEditingController(text: branch?.managerName ?? '');
    hours = TextEditingController(text: branch?.openingHours ?? '');

    isActive = branch?.isActive ?? true;
  }

  @override
  void dispose() {
    name.dispose();
    city.dispose();
    address.dispose();
    phone.dispose();
    email.dispose();
    manager.dispose();
    hours.dispose();
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
        color: Colors.white,
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
                  ...this._buildBranchFormBottomSheetFields1(context),
                  ...this._buildBranchFormBottomSheetFields2(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
