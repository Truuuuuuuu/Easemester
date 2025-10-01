import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert Firestore doc to NoteModel
  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NoteModel(
      id: doc
          .id, // use the Firestore doc ID, not just the saved field
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert NoteModel to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // copyWith method
  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
