import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

class FirestoreHelper {
  static FakeFirebaseFirestore createFakeFirestore() {
    return FakeFirebaseFirestore();
  }
}
