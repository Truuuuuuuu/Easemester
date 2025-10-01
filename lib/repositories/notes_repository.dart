import 'package:easemester_app/models/note_model.dart';
import 'package:easemester_app/services/firestore_service.dart';

class NotesRepository {
  final FirestoreService firestoreService;

  NotesRepository({required this.firestoreService});

  // Add a new note
  Future<void> addNote(String uid, NoteModel note) async {
    final docRef = await firestoreService
        .userNotesRef(uid)
        .add(note.toMap());
    await docRef.update({
      'id': docRef.id,
    }); // store the ID inside the document
  }

  // Get notes as a stream
  Stream<List<NoteModel>> getNotes(String uid) {
    return firestoreService
        .userNotesRef(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NoteModel.fromFirestore(doc))
              .toList(),
        );
  }

  // Update note
  Future<void> updateNote(
    String uid,
    NoteModel note,
  ) async {
    await firestoreService
        .userNotesRef(uid)
        .doc(note.id)
        .update(note.toMap());
  }

  // Delete note
  Future<void> deleteNote(String uid, String noteId) async {
    await firestoreService
        .userNotesRef(uid)
        .doc(noteId)
        .delete();
  }
}
