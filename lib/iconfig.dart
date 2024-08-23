import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/helpers/base/base_bloc.dart';
import 'package:note_app/helpers/service_locator.dart';
import 'package:path_provider/path_provider.dart';

Future<void> iconfig() async {
  Bloc.observer = const AppBlocObserver();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  await setupServiceLocator();
}
