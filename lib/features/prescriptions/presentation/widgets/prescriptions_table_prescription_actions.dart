part of 'prescriptions_table.dart';

class _PrescriptionActions extends StatelessWidget {
  const _PrescriptionActions({
    required this.prescription,
    required this.isSubmitting,
    required this.onView,
    required this.onVerify,
    required this.onReject,
    required this.onDispense,
  });

  final PrescriptionModel prescription;
  final bool isSubmitting;
  final ValueChanged<PrescriptionModel> onView;
  final ValueChanged<PrescriptionModel> onVerify;
  final ValueChanged<PrescriptionModel> onReject;
  final ValueChanged<PrescriptionModel> onDispense;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
          tooltip: context.translate(LangKeys.view),
          onPressed: isSubmitting
              ? null
              : () {
                  onView(prescription);
                },
          icon: const Icon(Icons.visibility_outlined),
        ),
        if (prescription.status == 'pending')
          IconButton(
            tooltip: context.translate(LangKeys.verify),
            onPressed: isSubmitting
                ? null
                : () {
                    onVerify(prescription);
                  },
            icon: const Icon(Icons.check_circle_outline),
          ),
        if (prescription.status == 'pending' ||
            prescription.status == 'verified')
          IconButton(
            tooltip: context.translate(LangKeys.reject),
            onPressed: isSubmitting
                ? null
                : () {
                    onReject(prescription);
                  },
            icon: const Icon(Icons.cancel_outlined),
          ),
        if (prescription.status == 'verified')
          TextButton(
            onPressed: isSubmitting
                ? null
                : () {
                    onDispense(prescription);
                  },
            child: TextApp(
              text: context.translate(LangKeys.dispense),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: context.textStyle,
            ),
          ),
      ],
    );
  }
}
