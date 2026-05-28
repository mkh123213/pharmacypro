part of 'staff_form_bottom_sheet.dart';

class _StaffFormBottomSheetState extends State<StaffFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _license;
  late final TextEditingController _hireDate;

  late String _role;
  String? _branchId;
  late bool _active;
  bool _isSaving = false;

  bool get _isEditing => widget.staff != null;

  List<BranchModel> get _activeBranches {
    return widget.branches.where((branch) => branch.isActive).toList();
  }

  @override
  void initState() {
    super.initState();

    final staff = widget.staff;

    _name = TextEditingController(text: staff?.fullName ?? '');
    _email = TextEditingController(text: staff?.email ?? '');
    _phone = TextEditingController(text: staff?.phone ?? '');
    _license = TextEditingController(text: staff?.licenseNumber ?? '');
    _hireDate = TextEditingController(text: staff?.hireDate ?? '');

    _role = staff?.role ?? 'technician';
    _branchId = staff?.branchId;
    _active = staff?.isActive ?? true;
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _license.dispose();
    _hireDate.dispose();
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
                  ...this._buildStaffFormBottomSheetFields1(context),
                  ...this._buildStaffFormBottomSheetFields2(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
