export 'words_list_event.dart';
export 'words_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_bloc/words_list_event.dart';
import 'package:funny_dictionary/busines_logic/words_list_bloc/words_list_state.dart';
import 'package:funny_dictionary/data/repository/words_list_repository.dart';

class WordsListBloc extends Bloc<WordsListEvent, WordsListState> {
  WordsListBloc(this.wordsListRepository) : super(WordsListStateInitialized()) {
    on<WordsListEventInit>((event, emit) async {
      try {
        emit(WordsListStateInitialized());
        final data = await wordsListRepository.getWordsList();

        emit(WordsListStateLoaded(data));
      } catch (error) {
        emit(WordsListStateFail(error.toString()));
      }
    });
  }

  final WordsListRepository wordsListRepository;
}
