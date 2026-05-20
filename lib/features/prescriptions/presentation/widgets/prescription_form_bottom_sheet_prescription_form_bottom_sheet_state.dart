part of 'prescription_form_bottom_sheet.dart';

class _PrescriptionFormBottomSheetState
    extends State<PrescriptionFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final patient = TextEditingController();
  final phone = TextEditingController();
  final doctor = TextEditingController();
  final license = TextEditingController();
  final issueDate = TextEditingController();
  final expiryDate = TextEditingController();
  final notes = TextEditingController();

  String? branchId;
  final items = <PrescriptionItemModel>[];

  bool _isSaving = false;

  @override
  void dispose() {
    patient.dispose();
    phone.dispose();
    doctor.dispose();
    license.dispose();
    issueDate.dispose();
    expiryDate.dispose();
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
                  ...this._buildPrescriptionFormBottomSheetFields1(context),
                  ...this._buildPrescriptionFormBottomSheetFields2(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
