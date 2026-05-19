import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/medication_model.dart';

part 'medications_state.freezed.dart';

@freezed
class MedicationsState with _$MedicationsState {
  const factory MedicationsState.initial() = MedicationsInitial;

  const factory MedicationsState.loading() = MedicationsLoading;

  const factory MedicationsState.loaded({
    required List<MedicationModel> medications,
    @Default('') String searchQuery,
    @Default('all') String selectedCategory,
    @Default(false) bool isSubmitting,
    @Default(null) String? errorMessage,
  }) = MedicationsLoaded;

  const factory MedicationsState.failure({required String message}) =
      MedicationsFailure;
}
