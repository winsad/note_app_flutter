// note: uuid is use with shared preference

class NoteEntity {
  int? id;
  // String? uuid;
  String title;
  String description;
  bool isLocked;

  NoteEntity({
    this.id,
    // this.uuid,
    required this.title,
    required this.description,
    required this.isLocked,
  }) {
    // uuid = uuid ?? const Uuid().v4();
  }

  // from json
  factory NoteEntity.fromJson(Map<String, dynamic> json) {
    return NoteEntity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isLocked: json['isLocked'] == 1 ? true : false,
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isLocked': isLocked ? 1 : 0,
    };
  }

  // copy with
  NoteEntity copyWith({
    int? id,
    String? title,
    String? description,
    bool? isLocked,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  // to string
  @override
  String toString() {
    return 'NoteEntity{id: $id, title: $title, description: $description, isLocked: $isLocked}';
  }
}
