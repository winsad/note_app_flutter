import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app/app_bloc.dart';
import 'package:note_app/features/dashboard/dashboard_page.dart';
import 'package:note_app/features/note/note_page.dart';
import 'package:note_app/features/splash/splash_page.dart';
import 'package:note_app/features/welcome/welcome_page.dart';
import 'package:note_app/helpers/base/base_page_state.dart';
import 'package:note_app/helpers/theme/app_theme.dart';
import 'package:note_app/helpers/unknown_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BasePageState<MyApp, AppBloc> {
  @override
  void initState() {
    bloc.add(const OnInitial());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: state.themeMode,
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(
                  builder: (context) => const SplashPage(),
                );
              case '/dashboard':
                return MaterialPageRoute(
                  builder: (context) => const DashboardPage(),
                );
              case '/note':
                final id = settings.arguments as dynamic;
                return MaterialPageRoute(
                  builder: (context) => NotePage(id: id),
                );
              case '/welcome':
                return MaterialPageRoute(
                  builder: (context) => const WelcomePage(),
                );

              default:
                return MaterialPageRoute(
                  builder: (context) => const UnknownPage(),
                );
            }
          },
        );
      },
    );
  }
}
