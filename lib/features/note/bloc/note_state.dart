import 'package:note_app/helpers/base/base_bloc.dart';

class NoteState extends BaseBlocState {
  int? id;
  String? uuid;
  String title;
  String description;
  bool isLocked;

  // hint
  String titleHint;
  String descriptionHint;

  // // button
  // String buttonTitle;
  // bool enabledButton;

  NoteState({
    this.id,
    this.uuid,
    this.title = '',
    this.description = '',
    this.isLocked = false,
    this.descriptionHint = '',
    this.titleHint = '',

    // this.buttonTitle = '',
    // this.enabledButton = false,
  });

  // copy with
  NoteState copyWith({
    int? id,
    String? uuid,
    String? title,
    String? description,
    bool? isLocked,
    String? titleHint,
    String? descriptionHint,
  }) {
    return NoteState(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      description: description ?? this.description,
      isLocked: isLocked ?? this.isLocked,
      titleHint: titleHint ?? this.titleHint,
      descriptionHint: descriptionHint ?? this.descriptionHint,
    );
  }

  // to string
  // @override
  // String toString() {
  //   return 'NoteState{id: $id, title: $title, description: $description, isLocked: $isLocked, completed: $completed, titleHint: $titleHint, descriptionHint: $descriptionHint}';
  // }
}
