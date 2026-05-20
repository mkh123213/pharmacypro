part of 'medication_form_bottom_sheet.dart';

class _MedicationFormBottomSheetState extends State<MedicationFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final MedicationFormController _formController;

  bool get _isEditing => _formController.isEditing;

  @override
  void initState() {
    super.initState();
    _formController = MedicationFormController(widget.medication);
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
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
                  ...this._buildMedicationFormBottomSheetFields1(context),
                  ...this._buildMedicationFormBottomSheetFields2(context),
                  ...this._buildMedicationFormBottomSheetFields3(context),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
