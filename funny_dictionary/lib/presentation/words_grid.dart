import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/word_page_bloc/word_page_bloc.dart';
import 'package:funny_dictionary/data/provider/local_word_meanings_provider.dart';
import 'package:funny_dictionary/data/provider/remote_word_meanings_provider.dart';
import 'package:funny_dictionary/data/repository/word_meanings_repository.dart';
import 'package:funny_dictionary/presentation/word_page.dart';

class WordsGrid extends StatelessWidget {
  const WordsGrid({super.key, required this.elements});
  final Map<String, dynamic> elements;
  @override
  Widget build(BuildContext context) {
    if (elements.entries.isEmpty) {
      return const Center(child: Text("No words yet"));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      addAutomaticKeepAlives: true,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<WordPage>(
                builder: (_) => BlocProvider<WordPageBloc>(
                  create: (context) => WordPageBloc(
                    // wordsListFavoritsBloc:
                    //     BlocProvider.of<WordsListFavoritsBloc>(context),
                    elements.entries.elementAt(index).key,
                    wordMeaningsRepository: WordMeaningsRepository(
                        RemoteWordMeaningsProvider(),
                        LocalWordMeaningsProvider()),
                  )..add(
                      WordPageEventInit(elements.entries.elementAt(index).key)),
                  child: const WordPage(),
                ),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(4),
                child: Center(
                  child: Text(elements.entries.elementAt(index).key),
                )),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: elements.entries.length,
    );
  }
}
