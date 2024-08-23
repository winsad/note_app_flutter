import 'package:flutter/material.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/data/repository/note_repository.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';

class AddNoteUseCase extends BaseFutureUseCase<AddNoteInput, AddNoteOutput> {
  const AddNoteUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  @override
  @protected
  Future<AddNoteOutput> buildUseCase(AddNoteInput input) async {
    final note = await _noteRepository.add(input.note);

    return AddNoteOutput(note: note);
  }
}

class AddNoteInput extends BaseUseCaseInput {
  final NoteEntity note;

  AddNoteInput(this.note);
}

class AddNoteOutput extends BaseUseCaseOutput {
  final NoteEntity note;

  AddNoteOutput({required this.note});
}
