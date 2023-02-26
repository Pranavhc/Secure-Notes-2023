import 'dart:convert';

class NoteModel {
  final String id;
  final String title;
  final List content;
  final String uid;
  final String createdAt;
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.uid,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'uid': uid,
      'createdAt': createdAt, // look into this later
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      content: List.from(map['content']),
      uid: map['createdBy'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source));
}
