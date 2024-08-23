import 'package:flutter/material.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/data/repository/note_repository.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';

class GetNoteUseCase extends BaseFutureUseCase<GetNoteInput, GetNoteOutput> {
  const GetNoteUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  @override
  @protected
  Future<GetNoteOutput> buildUseCase(GetNoteInput input) async {
    final note = await _noteRepository.getNote(input.id);

    return GetNoteOutput(note: note);
  }
}

class GetNoteInput extends BaseUseCaseInput {
  final int id;

  GetNoteInput(this.id);
}

class GetNoteOutput extends BaseUseCaseOutput {
  final NoteEntity? note;

  GetNoteOutput({required this.note});
}
