import 'dart:convert';
 
 String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id,
    isImportant,
    number,
    title,
    description,
    time
  ];

  static const String id = 'id';
  static const String isImportant = 'is_important';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}


List<Note> noteFromMap(String str) => List<Note>.from(json.decode(str).map((x) => Note.fromMap(x)));

String noteToMap(List<Note> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));



class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;
  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });


  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );
  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1, // 0 is false, 1 is true
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.now() 
      );
    Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.number: number,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };

    factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: int.parse(json["id"]),
        isImportant:  json["isImportant"] == 'true',
        number: int.parse(json["number"]) ,
        title: json["title"] ,
        description: json["description"],
        createdTime: DateTime.parse(json["createdTime"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "isImportant": isImportant,
        "number": number,
        "title": title,
        "description": description,
        "createdTime": createdTime.toIso8601String(),
    };
}
