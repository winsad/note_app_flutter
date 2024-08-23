import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/helpers/base/base_bloc.dart';

abstract class DashbardEvent extends BaseBlocEvent {
  const DashbardEvent();
}

class OnInitial extends DashbardEvent {
  const OnInitial();
}

class OnNotesLoaded extends DashbardEvent {
  final List<NoteEntity> notes;

  const OnNotesLoaded({required this.notes});
}

class OnStreamNote extends DashbardEvent {
  const OnStreamNote();
}
