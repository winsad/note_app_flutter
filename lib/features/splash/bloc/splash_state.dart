import 'package:note_app/helpers/base/base_bloc.dart';

class SplashState extends BaseBlocState {
  final bool isFirstLogin;

  SplashState({this.isFirstLogin = false});

  // copy with
  SplashState copyWith({bool? isFirstLogin}) {
    return SplashState(isFirstLogin: isFirstLogin ?? this.isFirstLogin);
  }

  // to string
  @override
  String toString() {
    return 'SplashState{isFirstLogin: $isFirstLogin}';
  }
}
