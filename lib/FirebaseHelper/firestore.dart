import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreCollectionHelper {

  static final CollectionReference users = FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(String displayName) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid.toString();
    await users.add({
      'Name': displayName,
      'UID': uid,
      'PlasticBagSavings': 0,
      'TransportSavings': 0
    });
  }

  static Future<Map<String, dynamic>?> getLoggedInUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid.toString();

      users.where("UID", isEqualTo: uid).get().then(
          (querySnapshot) {
            return querySnapshot.docs[0];
          },
        onError: (e) => print("Error completing: $e")
      );
    } else {
      return {};
    }
  }

  static Future<void> updateUserPoints(int pointsToAdd) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid.toString();

      try {
        final querySnapshot = await users.where('UID', isEqualTo: uid).get();

        if (querySnapshot.docs.isNotEmpty) {
          final userRef = querySnapshot.docs.first.reference;

          final currentPoints =
              (querySnapshot.docs.first.data() as Map<String,
                  dynamic>?)?['PlasticBagSavings'] ?? 0;

          await userRef.update(
              {'PlasticBagSavings': currentPoints + pointsToAdd});
        }
      } catch (e) {
          print('Error updating points: $e');
      }
    }
  }
}