part of 'prescriptions_body.dart';

extension PrescriptionsBodyUpdatePrescriptionStatus on PrescriptionsBody {
Future<void> _updatePrescriptionStatus({
    required BuildContext context,
    required PrescriptionModel prescription,
    required String status,
  }) async {
    final success = await context.read<PrescriptionsCubit>().updateStatus(
      prescription.id,
      status,
    );

    if (!context.mounted) return;

    if (!success) {
      final state = context.read<PrescriptionsCubit>().state;

      String message = context.translate(
        LangKeys.couldNotUpdatePrescriptionStatus,
      );

      if (state is PrescriptionsLoaded && state.errorMessage != null) {
        message = buildPrescriptionErrorMessage(context, state.errorMessage!);
      }

      ShowToast.showToastErrorTop(message: message);
      return;
    }

    String message;

    switch (status) {
      case 'verified':
        message = context.translate(LangKeys.prescriptionVerifiedSuccessfully);
        break;
      case 'dispensed':
        message = context.translate(LangKeys.prescriptionDispensedSuccessfully);
        break;
      case 'rejected':
        message = context.translate(LangKeys.prescriptionRejected);
        break;
      default:
        message = context.translate(
          LangKeys.prescriptionStatusUpdatedSuccessfully,
        );
    }

    ShowToast.showToastSuccessTop(message: message);
  }
}
