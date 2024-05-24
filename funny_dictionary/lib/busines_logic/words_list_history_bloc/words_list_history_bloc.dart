export 'words_list_history_event.dart';
export 'words_list_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/words_list_history_bloc/words_list_history_event.dart';
import 'package:funny_dictionary/busines_logic/words_list_history_bloc/words_list_history_state.dart';

import 'package:funny_dictionary/data/repository/word_meanings_repository.dart';

class WordsListHistoryBloc
    extends Bloc<WordsListHistoryEvent, WordsListHistoryState> {
  WordsListHistoryBloc(this.wordMeaningsRepository)
      : super(WordsListHistoryStateInitialized()) {
    on<WordsListHistoryEventInit>((event, emit) async {
      try {
        emit(WordsListHistoryStateInitialized());
        final data = await wordMeaningsRepository.localWordMeaningsProvider
            .getLocalWords();

        emit(WordsListHistoryStateLoaded(data));
      } catch (error) {
        emit(WordsListHistoryStateFail(error.toString()));
      }
    });
  }

  final WordMeaningsRepository wordMeaningsRepository;
}
