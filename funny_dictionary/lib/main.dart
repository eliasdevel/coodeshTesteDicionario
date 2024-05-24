import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_bloc/words_list_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_favorits_bloc/words_list_favorits_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_history_bloc/words_list_history_bloc.dart';
import 'package:funny_dictionary/data/provider/local_dictionary_provider.dart';
import 'package:funny_dictionary/data/provider/local_word_meanings_provider.dart';
import 'package:funny_dictionary/data/provider/remote_word_meanings_provider.dart';
import 'package:funny_dictionary/data/repository/word_meanings_repository.dart';
import 'package:funny_dictionary/data/repository/words_list_repository.dart';

import 'package:funny_dictionary/firebase_options.dart';
import 'package:funny_dictionary/presentation/app_home.dart';
import 'package:storage/storage.dart';

void main() async {
  //Init Firebase
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Storage.initialize();
  runApp(const DictionaryApp());
}

List<Map<String, dynamic>> entries = [];

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //

    return MultiBlocProvider(
        providers: [
          BlocProvider<WordsListBloc>(
            create: (context) => WordsListBloc(
              WordsListRepository(
                localDictionaryProvider: LocalDictionaryProvider(),
                localWordMeaningsProvider: LocalWordMeaningsProvider(),
              ),
            )..add(WordsListEventInit()),
          ),
          BlocProvider<WordsListHistoryBloc>(
            create: (context) => WordsListHistoryBloc(
              WordMeaningsRepository(
                  RemoteWordMeaningsProvider(), LocalWordMeaningsProvider()),
            )..add(WordsListHistoryEventInit()),
          ),
          BlocProvider<WordsListFavoritsBloc>(
            create: (context) => WordsListFavoritsBloc(
              WordMeaningsRepository(
                  RemoteWordMeaningsProvider(), LocalWordMeaningsProvider()),
            )..add(WordsListFavoritsEventInit()),
          ),
        ],
        child: MaterialApp(
          title: 'Dictionary',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AppHome(),
        ));
  }
}
