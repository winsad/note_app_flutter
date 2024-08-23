import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app/app_bloc.dart';
import 'package:note_app/features/dashboard/dashboard_bloc/dashboard_bloc.dart';
import 'package:note_app/helpers/base/base_page_state.dart';

class ThemeModeIconWidget extends StatefulWidget {
  const ThemeModeIconWidget({super.key});

  @override
  State<ThemeModeIconWidget> createState() => _ThemeModeIconWidgetState();
}

class _ThemeModeIconWidgetState
    extends BasePageState<ThemeModeIconWidget, DashboardBloc> {
  // @override
  // bool get wantKeepAlive => true;

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        late IconData icon;

        switch (state.themeMode) {
          case ThemeMode.system:
            icon = Icons.brightness_auto;
            break;
          case ThemeMode.light:
            icon = Icons.brightness_high;
            break;
          case ThemeMode.dark:
            icon = Icons.brightness_3;
            break;

          default:
            icon = Icons.brightness_auto;
        }

        return IconButton(
          icon: Icon(icon),
          onPressed: () {
            ThemeMode? themeMode;

            switch (state.themeMode) {
              case ThemeMode.system:
                themeMode = ThemeMode.light;
                break;
              case ThemeMode.light:
                themeMode = ThemeMode.dark;
                break;
              case ThemeMode.dark:
                themeMode = ThemeMode.system;
                break;

              case null:
            }

            appBloc.add(OnThemeChange(themeMode ?? ThemeMode.system));
          },
        );
      },
    );
  }
}
