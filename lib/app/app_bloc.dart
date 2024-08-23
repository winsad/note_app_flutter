import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';
import 'package:note_app/data/usecase/get_theme_mode_use_case.dart';
import 'package:note_app/data/usecase/save_theme_mode_use_case.dart';
import 'package:note_app/helpers/base/base_bloc.dart';
import 'package:note_app/helpers/base/note_change_observer.dart';

class AppBloc extends BaseBloc<AppEvent, AppState>
    implements NoteChangeObserverAble {
  AppBloc(
    this._getThemeModeUsecase,
    this._saveThemeModeUseCase,
  ) : super(AppState()) {
    on<OnInitial>(_onInitial, transformer: sequential());
    on<OnThemeChange>(_onThemeChange, transformer: sequential());
  }

  final GetThemeModeUsecase _getThemeModeUsecase;
  final SaveThemeModeUseCase _saveThemeModeUseCase;

  // on initial
  FutureOr<void> _onInitial(OnInitial event, Emitter<AppState> emit) async {
    return runBloc(action: () async {
      final output = _getThemeModeUsecase.execute(const NoInput());

      emit(state.copyWith(themeMode: output.themeMode));
    });
  }

  // on theme change
  FutureOr<void> _onThemeChange(
    OnThemeChange event,
    Emitter<AppState> emit,
  ) async {
    return runBloc(action: () async {
      await _saveThemeModeUseCase.execute(SaveThemeModeInput(event.themeMode));

      emit(state.copyWith(themeMode: event.themeMode));
    });
  }

  static final _noteChangeObserver = <NoteChangeObserver>[];

  @override
  void addObserver(NoteChangeObserver observer) {
    _noteChangeObserver.add(observer);
  }

  @override
  void removeObserver(NoteChangeObserver observer) {
    _noteChangeObserver.remove(observer);
  }

  @override
  void notifyEntityChange(List<NoteEntity> notes) {
    for (final observer in _noteChangeObserver) {
      observer.notifyChanged(notes);
    }
  }
}

abstract class AppEvent extends BaseBlocEvent {
  const AppEvent();
}

class OnInitial extends AppEvent {
  const OnInitial();
}

class OnThemeChange extends AppEvent {
  final ThemeMode themeMode;

  const OnThemeChange(this.themeMode);
}

class AppState extends BaseBlocState {
  AppState({
    this.themeMode,
  });

  ThemeMode? themeMode;

  // copy with
  AppState copyWith({
    ThemeMode? themeMode,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  // tostring
  @override
  String toString() {
    return 'AppState(themeMode: $themeMode)';
  }
}
