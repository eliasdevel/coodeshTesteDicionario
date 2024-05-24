import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/word_page_bloc/word_page_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_favorits_bloc/words_list_favorits_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_history_bloc/words_list_history_bloc.dart';
import 'package:funny_dictionary/presentation/meanings_widget.dart';
import 'package:funny_dictionary/presentation/word_player.dart';

class WordPage extends StatelessWidget {
  const WordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          BlocConsumer<WordPageBloc, WordPageState>(builder: (context, state) {
        switch (state) {
          case WordPageStateLoaded loaded:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 2 / 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: Colors.blueGrey[50]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ([
                        Text(
                          loaded.data.word ?? '',
                          style: const TextStyle(fontSize: 25),
                        ),
                        Text(
                          loaded.data.phonetic ?? '',
                          style:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      //Player
                      WordPlayer(
                        word: state.data,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<WordPageBloc>(context).add(
                            WordPageEventFavoriteWord(
                                state.data, state.favorite),
                          );
                        },
                        icon: state.favorite
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_outline),
                      ),
                    ],
                  ),
                ),
                if (state.data.meanings != null)
                  MeaningsWidget(meanings: state.data.meanings!)
              ],
            );
          case WordPageStateFail fail:
            return Center(
              child: Text('Word ${fail.word} not found!'),
            );
          default:
            return const SizedBox();
        }
      }, listener: (context, state) {
        log(state.toString());
        if (state is WordPageStateLoaded) {
          BlocProvider.of<WordsListFavoritsBloc>(context)
              .add(WordsListFavoritsEventInit());
          BlocProvider.of<WordsListHistoryBloc>(context)
              .add(WordsListHistoryEventInit());
        }
      }),
    );
  }
}
