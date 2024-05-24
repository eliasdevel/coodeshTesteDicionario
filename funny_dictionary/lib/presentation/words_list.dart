import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_bloc/words_list_bloc.dart';
import 'package:funny_dictionary/presentation/words_grid.dart';

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
              return WordsGrid(elements: state.data);

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
        },
        // buildWhen: (previous, current) => current is WordsListStateLoaded,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
