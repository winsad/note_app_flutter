import 'package:flutter/foundation.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/data/repository/note_repository.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';

class GetStreamNoteUseCase
    extends BaseStreamUseCase<NoInput, List<NoteEntity>> {
  final NoteRepository _noteRepository;

  GetStreamNoteUseCase(this._noteRepository);

  @override
  @protected
  Stream<List<NoteEntity>> buildUseCase(NoInput input) {
    return _noteRepository.getStramNotes();
  }
}
