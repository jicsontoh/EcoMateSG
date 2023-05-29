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

      QuerySnapshot snapshot = await users.where("UID", isEqualTo: uid).get();

      return snapshot.docs[0].data() as Map<String, dynamic>?;
    }

    return null;
  }

  static Future<void> addPlasticBagPoints(int pointsToAdd) async {
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

  static Future<void> addTransportPoints(int pointsToAdd) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid.toString();

      try {
        final querySnapshot = await users.where('UID', isEqualTo: uid).get();

        if (querySnapshot.docs.isNotEmpty) {
          final userRef = querySnapshot.docs.first.reference;

          final currentPoints =
              (querySnapshot.docs.first.data() as Map<String,
                  dynamic>?)?['TransportSavings'] ?? 0;

          await userRef.update(
              {'TransportSavings': currentPoints + pointsToAdd});
        }
      } catch (e) {
        print('Error updating points: $e');
      }
    }
  }
}