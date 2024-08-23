import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/data/usecase/add_note_use_case.dart';
import 'package:note_app/data/usecase/get_note_use_case.dart';
import 'package:note_app/data/usecase/remove_note_use_case.dart';
import 'package:note_app/data/usecase/update_note_use_case.dart';
import 'package:note_app/features/note/bloc/note_event.dart';
import 'package:note_app/features/note/bloc/note_state.dart';
import 'package:note_app/helpers/base/base_bloc.dart';

class NoteBloc extends BaseBloc<NoteEvent, NoteState> {
  NoteBloc(
    this._addNoteUseCase,
    this._getNoteUseCase,
    this._updateNoteUseCase,
    this._removeNoteUseCase,
  ) : super(NoteState()) {
    on<OnInitial>(_onInitial, transformer: sequential());
    on<OnAddNote>(_onAddNote, transformer: sequential());
    on<OnUpdateNote>(_onUpdateNote, transformer: sequential());
    on<OnTitleFieldChanged>(_onTitleFieldChanged, transformer: sequential());
    on<OnDescriptionFieldChanged>(_onDescriptionFieldChanged,
        transformer: sequential());
    on<OnSaveNote>(_onClickedSubmit, transformer: sequential());
    on<OnDeleteNote>(_onDeleted, transformer: sequential());
  }

  final GetNoteUseCase _getNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
  final AddNoteUseCase _addNoteUseCase;
  final RemoveNoteUseCase _removeNoteUseCase;

  late final titleController = TextEditingController();
  late final descriptionController = TextEditingController();

  late final quillController = QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );

  String _initialTitle = '';
  String _initialDescription = '';

  FutureOr<void> _onInitial(OnInitial event, Emitter<NoteState> emit) async {
    return runBloc(
      action: () async {
        if (event.id == null) {
          emit(state.copyWith(
            titleHint: 'Title',
            descriptionHint: 'Note',
          ));

          return;
        }

        // add(OnGetNote(id: event.id!));
        return runBloc(
          action: () async {
            final output =
                await _getNoteUseCase.execute(GetNoteInput(event.id!));
            NoteEntity? note = output.note;

            if (note == null) {
              emit(state.copyWith(titleHint: 'Title', descriptionHint: 'Note'));
              return;
            }

            titleController.text = note.title;
            descriptionController.text = note.description;

            _initialTitle = note.title;
            _initialDescription = note.description;

            emit(state.copyWith(
              id: note.id,
              title: note.title,
              description: note.description,
              isLocked: note.isLocked,
            ));
          },
        );
      },
    );
  }

  // on add note
  FutureOr<void> _onAddNote(OnAddNote event, Emitter<NoteState> emit) async {
    return runBloc(
      action: () async {
        final note = NoteEntity(
          title: state.title,
          description: state.description,
          isLocked: state.isLocked,
        );

        await _addNoteUseCase.execute(AddNoteInput(note));

        emit(state.copyWith());
      },
    );
  }

  // on update note
  FutureOr<void> _onUpdateNote(
      OnUpdateNote event, Emitter<NoteState> emit) async {
    return runBloc(
      action: () async {
        final note = NoteEntity(
          id: state.id,
          title: state.title,
          description: state.description,
          isLocked: state.isLocked,
        );

        await _updateNoteUseCase.execute(UpdateNoteInput(note));

        emit(state.copyWith());
      },
    );
  }

  // on title field changed
  FutureOr<void> _onTitleFieldChanged(
      OnTitleFieldChanged event, Emitter<NoteState> emit) async {
    emit(state.copyWith(title: event.title));
  }

  // on description field changed
  FutureOr<void> _onDescriptionFieldChanged(
      OnDescriptionFieldChanged event, Emitter<NoteState> emit) async {
    emit(state.copyWith(description: event.description));
  }

  // on click submit
  FutureOr<void> _onClickedSubmit(OnSaveNote event, Emitter<NoteState> emit) {
    if (_isEnablesSave) add(state.id == null ? OnAddNote() : OnUpdateNote());

    if (_isRemoveNote) {
      add(OnDeleteNote(id: state.id!));
    }
  }

  // on deleted
  FutureOr<void> _onDeleted(OnDeleteNote event, Emitter<NoteState> emit) {
    return runBloc(
      action: () async {
        await _removeNoteUseCase.execute(RemoveNoteInput(event.id));

        emit(state.copyWith());
      },
    );
  }

  bool get _isRemoveNote =>
      state.id != null &&
      state.title.trim().isEmpty &&
      state.description.trim().isEmpty;

  bool get _isEnablesSave => !_isRemoveNote && _isChanged;

  bool get _isChanged =>
      state.title != _initialTitle || state.description != _initialDescription;
}
