import 'package:hive/hive.dart';
import 'package:note_app/data/model/note_entity.dart';

class HiveHelper {
  HiveHelper(this._noteBox);

  final Box<NoteEntity> _noteBox;

  Future<NoteEntity?> getNoteBox() async {
    return _noteBox.get('');
  }

  Future<void> addNoteBox(NoteEntity noteEntity) async {
    await _noteBox.put('', noteEntity);
  }
}
