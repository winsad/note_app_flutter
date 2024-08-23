import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';
import 'package:note_app/data/usecase/get_all_note_use_case.dart';
import 'package:note_app/data/usecase/get_stream_note_use_case.dart';
import 'package:note_app/features/dashboard/dashboard_bloc/dashboard_event.dart';
import 'package:note_app/features/dashboard/dashboard_bloc/dashboard_state.dart';
import 'package:note_app/helpers/base/base_bloc.dart';
import 'package:note_app/helpers/logger.dart';

class DashboardBloc extends BaseBloc<DashbardEvent, DashbardState> {
  DashboardBloc(
    this._getAllNoteUseCase,
    this._getStreamNoteUseCase,
  ) : super(const DashbardState()) {
    on<OnInitial>(_onInitial, transformer: sequential());
    on<OnNotesLoaded>(_onLoadAllNotes, transformer: sequential());
    on<OnStreamNote>(_onStreamNote, transformer: sequential());
  }

  final GetAllNoteUseCase _getAllNoteUseCase;
  final GetStreamNoteUseCase _getStreamNoteUseCase;

  FutureOr<void> _onInitial(
      OnInitial event, Emitter<DashbardState> emit) async {
    return runBloc(action: () async {
      final output = await _getAllNoteUseCase.execute(const NoInput());

      emit(state.copyWith(notes: output.notes, isLoading: false));
      // add(OnNotesLoaded(notes: output.notes));
    });
  }

  // on load all notes
  FutureOr<void> _onLoadAllNotes(
      OnNotesLoaded event, Emitter<DashbardState> emit) async {
    emit(state.copyWith(notes: event.notes, isLoading: false));
  }

  // on stream note
  FutureOr<void> _onStreamNote(
    OnStreamNote event,
    Emitter<DashbardState> emit,
  ) async {
    return emit.forEach<List<NoteEntity>>(
      _getStreamNoteUseCase.execute(const NoInput()),
      onData: (List<NoteEntity> notes) {
        return state.copyWith(notes: notes, isLoading: false);
      },
      onError: (error, stackTrace) {
        Logger.e('error: $error');
        return state.copyWith(notes: [], isLoading: false);
      },
    );
  }
}
