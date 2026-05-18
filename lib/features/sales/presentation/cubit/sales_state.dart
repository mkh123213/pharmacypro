import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/sale_model.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';

part 'sales_state.freezed.dart';

@freezed
class SalesState with _$SalesState {
  const factory SalesState.initial() = SalesInitial;
  const factory SalesState.loading() = SalesLoading;
  const factory SalesState.loaded({
    required List<SaleModel> sales, required List<MedicationModel> medications, required List<BranchModel> branches, @Default('') String searchQuery, @Default(false) bool isSubmitting,
  }) = SalesLoaded;
  const factory SalesState.failure({required String message}) = SalesFailure;
}
