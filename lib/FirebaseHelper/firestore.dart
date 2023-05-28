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
        return {}; // Return an empty map or null as per your requirement
      }
    }
}