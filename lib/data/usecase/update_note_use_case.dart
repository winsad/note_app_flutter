import 'package:flutter/material.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/data/repository/note_repository.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';

class UpdateNoteUseCase
    extends BaseFutureUseCase<UpdateNoteInput, UpdateNoteOutput> {
  const UpdateNoteUseCase(this._noteRepository);
  final NoteRepository _noteRepository;

  @override
  @protected
  Future<UpdateNoteOutput> buildUseCase(UpdateNoteInput input) async {
    final note = await _noteRepository.update(input.note);

    return UpdateNoteOutput(note: note);
  }
}

class UpdateNoteInput extends BaseUseCaseInput {
  final NoteEntity note;

  UpdateNoteInput(this.note);
}

class UpdateNoteOutput extends BaseUseCaseOutput {
  final NoteEntity note;

  UpdateNoteOutput({required this.note});
}
