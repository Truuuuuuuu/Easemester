import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easemester_app/models/task_model.dart';
import 'package:easemester_app/services/firestore_service.dart';

class ChecklistRepository {
  final FirestoreService firestoreService;

  ChecklistRepository({required this.firestoreService});

  // Reference to user's checklist
  CollectionReference<Map<String, dynamic>> _userChecklistRef(String uid) {
    return firestoreService.userNotesRef(uid).parent!.collection('checklist');
  }

  Future<void> addItem(String uid, ChecklistItem item) async {
    await _userChecklistRef(uid).add(item.toMap());
  }

  Stream<List<ChecklistItem>> getItems(String uid) {
    return _userChecklistRef(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => ChecklistItem.fromFirestore(doc)).toList(),
        );
  }

  Future<void> updateItem(String uid, ChecklistItem item) async {
    await _userChecklistRef(uid).doc(item.id).update(item.toMap());
  }

  Future<void> deleteItem(String uid, String id) async {
    await _userChecklistRef(uid).doc(id).delete();
  }
}
