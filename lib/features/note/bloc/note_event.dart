import 'package:note_app/helpers/base/base_bloc.dart';

abstract class NoteEvent extends BaseBlocEvent {
  const NoteEvent();
}

class OnInitial extends NoteEvent {
  // final String? id;
  final int? id;

  OnInitial({this.id});
}

class OnAddNote extends NoteEvent {}

class OnUpdateNote extends NoteEvent {}

class OnTitleFieldChanged extends NoteEvent {
  final String title;

  OnTitleFieldChanged({required this.title});
}

class OnDescriptionFieldChanged extends NoteEvent {
  final String description;

  OnDescriptionFieldChanged({required this.description});
}

class OnDeleteNote extends NoteEvent {
  final int id;
  // final String uuid;

  OnDeleteNote({
    required this.id,
    // required this.uuid,
  });
}

class OnSaveNote extends NoteEvent {}
