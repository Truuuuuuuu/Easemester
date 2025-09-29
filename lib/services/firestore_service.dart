import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save user data after signup
  Future<void> saveUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).set(data);
  }

  // Get user data
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) async {
    return await _db.collection("users").doc(uid).get();
  }

  // Update user data
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }

  // Delete user
  Future<void> deleteUser(String uid) async {
    await _db.collection("users").doc(uid).delete();
  }
}
