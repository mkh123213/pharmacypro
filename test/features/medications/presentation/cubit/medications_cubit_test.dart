import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pharmacypro/features/medications/presentation/cubit/medications_cubit.dart';
import 'package:pharmacypro/features/medications/presentation/cubit/medications_state.dart';
import '../../../../helpers/mock_medications_repo.dart';

void main() {
  late MockMedicationsRepo mockMedicationsRepo;
  late MedicationsCubit medicationsCubit;

  setUp(() {
    mockMedicationsRepo = MockMedicationsRepo();
    medicationsCubit = MedicationsCubit(medicationsRepo: mockMedicationsRepo);
  });

  group('MedicationsCubit', () {
    test('initial state is MedicationsState.initial()', () {
      expect(medicationsCubit.state, const MedicationsState.initial());
    });
  });
}
