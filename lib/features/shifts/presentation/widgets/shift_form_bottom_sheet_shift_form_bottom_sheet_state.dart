part of 'shift_form_bottom_sheet.dart';

class _ShiftFormBottomSheetState extends State<ShiftFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  String? staffId;
  String? branchId;

  final date = TextEditingController();
  final start = TextEditingController();
  final end = TextEditingController();
  final notes = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    date.dispose();
    start.dispose();
    end.dispose();
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
                  ...this._buildShiftFormBottomSheetFields1(context),
                  ...this._buildShiftFormBottomSheetFields2(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
