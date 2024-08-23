import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/splash/bloc/splash_bloc.dart';
import 'package:note_app/features/splash/bloc/splash_event.dart';
import 'package:note_app/features/splash/bloc/splash_state.dart';
import 'package:note_app/helpers/base/base_page_state.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, SplashBloc> {
  @override
  void initState() {
    bloc.add(OnInitial());
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listenWhen: (previous, current) =>
          previous.isFirstLogin != current.isFirstLogin,
      listener: (context, state) {
        if (state.isFirstLogin) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/welcome');
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 100,
            child: Lottie.asset('assets/loading.json'),
          ),
        ),
      ),
    );
  }
}
