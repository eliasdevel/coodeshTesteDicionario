import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/word_page_bloc/bloc.dart';
import 'package:funny_dictionary/busines_logic/word_page_bloc/word_page_bloc.dart';
import 'package:funny_dictionary/data/provider/remote_word_meanings_provider.dart';
import 'package:funny_dictionary/data/repository/word_meanings_repository.dart';
import 'package:funny_dictionary/firebase_options.dart';
import 'package:funny_dictionary/presentation/app_home.dart';
import 'package:funny_dictionary/presentation/word_page.dart';

void main() {
  //Init Firebase
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const DictionaryApp());
}

List<Map<String, dynamic>> entries = [];

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      title: 'Dictionary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppHome(),
    );
  }
}
