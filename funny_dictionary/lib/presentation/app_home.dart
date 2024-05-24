import 'package:flutter/material.dart';

import 'package:funny_dictionary/presentation/words_list.dart';
import 'package:funny_dictionary/presentation/words_list_favorits.dart';
import 'package:funny_dictionary/presentation/words_list_history.dart';

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
          body: const TabBarView(
            children: [
              WordsList(),
              WordsListHistory(),
              WordsListFavorits(),
            ],
          )),
    );
  }
}
