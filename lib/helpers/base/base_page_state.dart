import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app/app_bloc.dart';
import 'package:note_app/helpers/base/base_bloc.dart';
import 'package:note_app/helpers/service_locator.dart';

abstract class BasePageStateDelegate<T extends StatefulWidget,
    B extends BaseBloc> extends State<T> {}

abstract class BasePageState<T extends StatefulWidget, B extends BaseBloc>
    extends BasePageStateDelegate<T, B> with AutomaticKeepAliveClientMixin {
  // app bloc
  late final AppBloc appBloc = getIt.get<AppBloc>();

  // screen bloc
  late final B bloc = getIt.get<B>()..appBloc = appBloc;

  // life cycle
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    _listener = AppLifecycleListener(
      onStateChange: onStateChange,
    );
    super.initState();
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;

  Widget buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiBlocProvider(
      providers: [
        // add app bloc
        BlocProvider(create: (_) => appBloc),
        // add screen bloc
        BlocProvider(create: (_) => bloc),
      ],
      child: buildPage(context),
    );
  }

  void onStateChange(AppLifecycleState state) {
    // do nth
  }
}
