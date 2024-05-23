import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_bloc/words_list_bloc.dart';
import 'package:funny_dictionary/data/provider/local_dictionary_provider.dart';
import 'package:funny_dictionary/data/repository/words_list_repository.dart';
import 'package:funny_dictionary/presentation/words_list.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              child: Text('Words List'),
            ),
            Tab(
              child: Text('History'),
            ),
            Tab(
              child: Text('Favorits'),
            )
          ]),
        ),
        body: TabBarView(
          children: [
            BlocProvider<WordsListBloc>(
              create: (context) => WordsListBloc(
                WordsListRepository(
                  localDictionaryProvider: LocalDictionaryProvider(),
                ),
              )..add(WordsListEventInit()),
              child: const WordsList(),
            ),
            const Text("History"),
            const Text("Favorits")
          ],
        ),
      ),
    );
  }
}
