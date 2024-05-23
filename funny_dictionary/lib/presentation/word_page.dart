import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/word_page_bloc/word_page_bloc.dart';

class WordPage extends StatelessWidget {
  const WordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<WordPageBloc, WordPageState>(
          builder: (context, state) {
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
                              loaded.data.word!,
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              loaded.data.phonetic!,
                              style: TextStyle(fontSize: 20),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    //Player
                    TextButton(
                      onPressed: () => BlocProvider.of<WordPageBloc>(context)
                        ..add(WordPageEventPlayAudio(state.data)),
                      child: Text("Audio"),
                    )
                  ],
                );
              case WordPageStateFail fail:
                return Center(
                  child: Text('Word ${fail.word} not found!'),
                );
              default:
                return const SizedBox();
            }
          },
          listener: (context, state) {}),
    );
  }
}
