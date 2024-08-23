import 'package:note_app/app/app_bloc.dart';
import 'package:note_app/data/local/sql_lite_helper.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:rxdart/subjects.dart';

abstract class NoteRepository {
  Future<List<NoteEntity>> getNotes();

  Stream<List<NoteEntity>> getStramNotes();

  Future<NoteEntity?> getNote(int id);

  Future<NoteEntity> add(NoteEntity note);

  Future<NoteEntity> update(NoteEntity note);

  Future<void> delete(int id);
}

class NoteRepositoryImpl implements NoteRepository {
  const NoteRepositoryImpl(
    // this._sharedPreferenceHelper,
    this._appBloc,
    this._sqlLiteHelper,
  );

  // final SharedPreferenceHelper _sharedPreferenceHelper;
  // ignore: unused_field
  final AppBloc _appBloc;
  final SqlLiteHelper _sqlLiteHelper;

  static List<NoteEntity> _notes = <NoteEntity>[];
  static final BehaviorSubject<List<NoteEntity>> _noteBehavior =
      BehaviorSubject<List<NoteEntity>>();

  @override
  Future<NoteEntity> add(NoteEntity note) async {
    _notes.add(note);

    await _sqlLiteHelper.insert(note);
    await getNotes();

    return note;
  }

  @override
  Future<void> delete(
    // String id,
    int id,
  ) async {
    _notes.removeWhere((element) => element.id == id);
    await _sqlLiteHelper.delete(id);
    await getNotes();
  }

  @override
  Future<List<NoteEntity>> getNotes() async {
    _notes = await _sqlLiteHelper.getAll();

    _notifiyNoteChange();

    return [..._notes];
  }

  @override
  Future<NoteEntity> update(NoteEntity note) async {
    final index = _notes.indexWhere((element) => element.id == note.id);
    _notes[index] = note;

    await _sqlLiteHelper.update(note);
    await getNotes();

    return note;
  }

  @override
  Future<NoteEntity?> getNote(int id) async {
    return await _sqlLiteHelper.getNote(id);
  }

  void _notifiyNoteChange() {
    // _appBloc.notifyEntityChange([..._notes]);
    _noteBehavior.add([..._notes]);
  }

  @override
  Stream<List<NoteEntity>> getStramNotes() {
    getNotes();

    return _noteBehavior.stream;
  }
}
