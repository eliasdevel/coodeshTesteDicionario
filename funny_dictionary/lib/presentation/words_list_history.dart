import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_history_bloc/words_list_history_bloc.dart';
import 'package:funny_dictionary/presentation/words_grid.dart';

class WordsListHistory extends StatelessWidget {
  const WordsListHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WordsListHistoryBloc, WordsListHistoryState>(
        builder: (context, state) {
          switch (state) {
            case WordsListHistoryStateLoaded _:
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
