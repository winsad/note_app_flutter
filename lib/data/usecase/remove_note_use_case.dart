import 'package:flutter/material.dart';
import 'package:note_app/data/repository/note_repository.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';

class RemoveNoteUseCase extends BaseFutureUseCase<RemoveNoteInput, NoOutput> {
  const RemoveNoteUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  @override
  @protected
  Future<NoOutput> buildUseCase(RemoveNoteInput input) async {
    await _noteRepository.delete(input.id);

    return const NoOutput();
  }
}

class RemoveNoteInput extends BaseUseCaseInput {
  // final String id;
  final int id;

  RemoveNoteInput(this.id);
}
