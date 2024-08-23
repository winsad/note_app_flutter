import 'package:note_app/data/model/note_entity.dart';

abstract class NoteChangeObserverAble {
  void addObserver(NoteChangeObserver observer);

  void removeObserver(NoteChangeObserver observer);

  void notifyEntityChange(List<NoteEntity> notes);
}

abstract class NoteChangeObserver {
  void notifyChanged(List<NoteEntity> notes);
}
