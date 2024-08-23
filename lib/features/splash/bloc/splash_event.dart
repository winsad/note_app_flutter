import 'package:note_app/helpers/base/base_bloc.dart';

abstract class SplashEvent extends BaseBlocEvent {
  const SplashEvent();
}

class OnInitial extends SplashEvent {}
