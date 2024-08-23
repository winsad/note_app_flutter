import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app/app_bloc.dart';
import 'package:note_app/helpers/logger.dart';

abstract class BaseBloc<E extends BaseBlocEvent, S extends BaseBlocState>
    extends BaseBlocDelegate<E, S> {
  BaseBloc(super.initialState);
}

abstract class BaseBlocDelegate<E extends BaseBlocEvent,
    S extends BaseBlocState> extends Bloc<E, S> {
  BaseBlocDelegate(super.initialState);
  late final AppBloc appBloc;

  @override
  void add(event) {
    if (!isClosed) {
      super.add(event);
    } else {
      // do nothing
    }
  }

  Future<void> runBloc({
    required Future<void> Function() action,
  }) async {
    try {
      await action.call();
    } catch (e) {
      Logger.e('Bloc error: $e');
    }
  }
}

// base event
abstract class BaseBlocEvent {
  const BaseBlocEvent();
}

// base state
abstract class BaseBlocState {
  const BaseBlocState();
}

// bloc observer
class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit && kDebugMode) Logger.d('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (kDebugMode) Logger.d('${bloc.runtimeType} $transition');
    // print(transition);
  }
}
