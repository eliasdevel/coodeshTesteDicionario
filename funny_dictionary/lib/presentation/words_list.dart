import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/word_page_bloc/word_page_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_bloc/bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_bloc/words_list_state.dart';
import 'package:funny_dictionary/data/provider/remote_word_meanings_provider.dart';
import 'package:funny_dictionary/data/repository/word_meanings_repository.dart';
import 'package:funny_dictionary/presentation/word_page.dart';

//Used Statefull with AutomaticKeepAliveClientMixin to avoid reload when change tab.
class WordsList extends StatefulWidget {
  const WordsList({super.key});
  @override
  State<WordsList> createState() => _WordsListState();
}

class _WordsListState extends State<WordsList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocConsumer<WordsListBloc, WordsListState>(
        builder: (context, state) {
          switch (state) {
            case WordsListStateLoaded _:
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<WordPage>(
                          builder: (_) => BlocProvider<WordPageBloc>(
                            create: (context) => WordPageBloc(
                              state.data.entries.elementAt(index).key,
                              wordMeaningsRepository: WordMeaningsRepository(
                                RemoteWordMeaningsProvider(),
                              ),
                            )..add(WordPageEventInit(
                                state.data.entries.elementAt(index).key)),
                            child: const WordPage(),
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(state.data.entries.elementAt(index).key),
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: state.data.entries.length,
              );

            default:
              return const SizedBox();
          }
        },
        listener: (context, state) {
          switch (state) {
            case WordsListStateInitialized _:
              //Start Loader
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            case WordsListStateLoaded _:
              //Ends Loader
              Navigator.of(context).pop();
            case WordsListStateFail _:
              //Fail
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Error while try to retrive data"),
                ),
              );
          }

          log(state.toString());
        },
        // buildWhen: (previous, current) => current is WordsListStateLoaded,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
