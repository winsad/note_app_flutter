import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:note_app/app/app_bloc.dart';
import 'package:note_app/data/local/hive_helper.dart';
import 'package:note_app/data/local/shared_preference_helper.dart';
import 'package:note_app/data/local/sql_lite_helper.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/data/repository/app_repository.dart';
import 'package:note_app/data/repository/note_repository.dart';
import 'package:note_app/data/usecase/add_note_use_case.dart';
import 'package:note_app/data/usecase/get_all_note_use_case.dart';
import 'package:note_app/data/usecase/get_is_login_use_case.dart';
import 'package:note_app/data/usecase/get_note_use_case.dart';
import 'package:note_app/data/usecase/get_stream_note_use_case.dart';
import 'package:note_app/data/usecase/get_theme_mode_use_case.dart';
import 'package:note_app/data/usecase/remove_note_use_case.dart';
import 'package:note_app/data/usecase/save_theme_mode_use_case.dart';
import 'package:note_app/data/usecase/set_first_login_use_case.dart';
import 'package:note_app/data/usecase/update_note_use_case.dart';
import 'package:note_app/features/dashboard/dashboard_bloc/dashboard_bloc.dart';
import 'package:note_app/features/note/bloc/note_bloc.dart';
import 'package:note_app/features/splash/bloc/splash_bloc.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // sqflite
  final database = await _initDatabase();
  getIt.registerSingleton<SqlLiteHelper>(SqlLiteHelper(database));

  // hive
  final notebox = await Hive.openBox<NoteEntity>('table_note');
  getIt.registerLazySingleton<HiveHelper>(() => HiveHelper(notebox));

  // sharedpreference
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // bloc
  getIt.registerFactory<SplashBloc>(() => SplashBloc(
        getIt.get<GetIsLoginUsecase>(),
        getIt.get<SetFirstLoginUseCase>(),
      ));

  getIt.registerFactory<DashboardBloc>(() => DashboardBloc(
        getIt.get<GetAllNoteUseCase>(),
        getIt.get<GetStreamNoteUseCase>(),
      ));
  getIt.registerFactory<NoteBloc>(() => NoteBloc(
        getIt.get<AddNoteUseCase>(),
        getIt.get<GetNoteUseCase>(),
        getIt.get<UpdateNoteUseCase>(),
        getIt.get<RemoveNoteUseCase>(),
      ));

  // repository
  getIt.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(getIt.get<SharedPreferenceHelper>()));
  getIt.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl(
        // getIt.get<SharedPreferenceHelper>(),
        getIt.get<AppBloc>(),
        getIt.get<SqlLiteHelper>(),
      ));

  // usecase
  getIt.registerFactory<AddNoteUseCase>(
      () => AddNoteUseCase(getIt.get<NoteRepository>()));
  getIt.registerFactory<GetAllNoteUseCase>(
      () => GetAllNoteUseCase(getIt.get<NoteRepository>()));
  getIt.registerFactory<GetIsLoginUsecase>(
      () => GetIsLoginUsecase(getIt.get<AppRepository>()));
  getIt.registerFactory<GetNoteUseCase>(
      () => GetNoteUseCase(getIt.get<NoteRepository>()));
  getIt.registerFactory<RemoveNoteUseCase>(
      () => RemoveNoteUseCase(getIt.get<NoteRepository>()));
  getIt.registerFactory<UpdateNoteUseCase>(
      () => UpdateNoteUseCase(getIt.get<NoteRepository>()));
  getIt.registerFactory<GetStreamNoteUseCase>(
      () => GetStreamNoteUseCase(getIt.get<NoteRepository>()));
  getIt.registerFactory<SetFirstLoginUseCase>(
      () => SetFirstLoginUseCase(getIt.get<AppRepository>()));
  getIt.registerFactory<GetThemeModeUsecase>(
      () => GetThemeModeUsecase(getIt.get<AppRepository>()));
  getIt.registerFactory<SaveThemeModeUseCase>(
      () => SaveThemeModeUseCase(getIt.get<AppRepository>()));

  // data
  getIt.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(
    getIt.get<SharedPreferences>(),
  ));

  getIt.registerSingleton<AppBloc>(
    AppBloc(
      getIt.get<GetThemeModeUsecase>(),
      getIt.get<SaveThemeModeUseCase>(),
    ),
  );
  // Register AppRepositoryImpl as AppRepository
  // getIt.registerSingleton<AppRepository>(AppRepositoryImpl(sharedPreferences));
}

Future<Database> _initDatabase() async {
  final databasePath = await getDatabasesPath();

  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  final path = join(databasePath, 'app_sqflite_database.db');

  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  return await openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE `table_note` (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, isLocked BOOLEAN)',
      );
    },
    version: 1,
    onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
  );
}
