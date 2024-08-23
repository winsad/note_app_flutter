import 'package:flutter/material.dart';
import 'package:note_app/app/my_app.dart';
import 'package:note_app/iconfig.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await iconfig();

  runApp(const MyApp());
}
