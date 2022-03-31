import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  final firestoreInstance = FirebaseFirestore.instance;
  String currentVersion = "version1";

  Future<bool> checkInviteCodeValidity(String code) async {
    final result = await firestoreInstance
        .collection("invitecode")
        .where(currentVersion, arrayContains: code)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return false;
      } else {
        return true;
      }
    }).onError((error, stackTrace) async {
      if (error.toString() == "Bad state: No element") {
        return false;
      } else {
        throw Exception("Something went wrong");
      }
    });
    return result;
  }
}
