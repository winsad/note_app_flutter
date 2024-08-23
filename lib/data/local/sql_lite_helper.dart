import 'package:note_app/data/model/note_entity.dart';
import 'package:sqflite/sqflite.dart';

class SqlLiteHelper {
  SqlLiteHelper(this._db);

  final Database _db;

  static const String _tableNote = 'table_note';
  static const String columnId = 'id';
  // static const String columnUuid = 'uuid';
  static const String columnTitle = 'title';
  static const String columnDescription = 'description';
  static const String columnIsLocked = 'isLocked';

  Future<NoteEntity> insert(NoteEntity todo) async {
    await _db.insert(_tableNote, todo.toJson());

    return todo;
  }

  Future<List<NoteEntity>> getAll() async {
    List<Map> maps = await _db.query(
      _tableNote,
      columns: [columnId, columnTitle, columnDescription, columnIsLocked],
    );

    return List.generate(
      maps.length,
      (i) {
        return NoteEntity.fromJson(maps[i] as Map<String, dynamic>);
      },
    );
  }

  Future<NoteEntity?> getNote(int id) async {
    List<Map> maps = await _db.query(
      _tableNote,
      columns: [
        columnId,
        // columnUuid,
        columnTitle,
        columnDescription,
        columnIsLocked
      ],
      where: '$columnId = ?',
      whereArgs: [id],
      // limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return NoteEntity.fromJson(maps.first as Map<String, dynamic>);
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      _tableNote,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(NoteEntity note) async {
    return await _db.update(
      _tableNote,
      note.toJson(),
      where: '$columnId = ?',
      whereArgs: [note.id],
    );
  }
}
