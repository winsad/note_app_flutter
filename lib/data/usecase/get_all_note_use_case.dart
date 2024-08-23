import 'package:flutter/material.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/data/repository/note_repository.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';

class GetAllNoteUseCase extends BaseFutureUseCase<NoInput, GetAllNoteOutput> {
  const GetAllNoteUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  @override
  @protected
  Future<GetAllNoteOutput> buildUseCase(NoInput input) async {
    final notes = await _noteRepository.getNotes();

    return GetAllNoteOutput(notes: notes);
  }
}

class GetAllNoteOutput extends BaseUseCaseOutput {
  final List<NoteEntity> notes;

  GetAllNoteOutput({required this.notes});
}
