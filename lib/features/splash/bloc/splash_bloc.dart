import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';
import 'package:note_app/data/usecase/get_is_login_use_case.dart';
import 'package:note_app/data/usecase/set_first_login_use_case.dart';
import 'package:note_app/features/splash/bloc/splash_event.dart';
import 'package:note_app/features/splash/bloc/splash_state.dart';
import 'package:note_app/helpers/base/base_bloc.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc(
    this._getIsLoginUsecase,
    this._setFirstLoginUseCase,
  ) : super(SplashState()) {
    on<OnInitial>(_onInitial, transformer: sequential());
  }

  final GetIsLoginUsecase _getIsLoginUsecase;
  final SetFirstLoginUseCase _setFirstLoginUseCase;

  FutureOr<void> _onInitial(OnInitial event, Emitter<SplashState> emit) async {
    return runBloc(action: () async {
      await Future.delayed(const Duration(seconds: 1));

      final output = _getIsLoginUsecase.execute(const NoInput());

      if (output.isFirstLogin) {
        await _setFirstLoginUseCase.execute(const NoInput());
      }

      emit(state.copyWith(isFirstLogin: output.isFirstLogin));
    });
  }
}
