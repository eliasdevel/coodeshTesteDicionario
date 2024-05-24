import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_favorits_bloc/words_list_favorits_bloc.dart';

import 'package:funny_dictionary/presentation/words_grid.dart';

class WordsListFavorits extends StatelessWidget {
  const WordsListFavorits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WordsListFavoritsBloc, WordsListFavoritsState>(
        builder: (context, state) {
          switch (state) {
            case WordsListFavoritsStateLoaded _:
              return WordsGrid(elements: state.data);
            default:
              return const SizedBox();
          }
        },
        listener: (context, state) {},
        // buildWhen: (previous, current) => current is WordsListStateLoaded,
      ),
    );
  }
}
