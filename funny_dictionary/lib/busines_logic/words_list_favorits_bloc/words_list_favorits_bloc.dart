import 'package:funny_dictionary/data/repository/word_meanings_repository.dart';

import 'words_list_favorits_event.dart';
import 'words_list_favorits_state.dart';
export 'words_list_favorits_event.dart';
export 'words_list_favorits_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordsListFavoritsBloc
    extends Bloc<WordsListFavoritsEvent, WordsListFavoritsState> {
  WordsListFavoritsBloc(this.wordMeaningsRepository)
      : super(WordsListFavoritsStateInitialized()) {
    on<WordsListFavoritsEventInit>((event, emit) async {
      try {
        emit(WordsListFavoritsStateInitialized());
        final data = await wordMeaningsRepository.localWordMeaningsProvider
            .getLocalFavorits();

        emit(WordsListFavoritsStateLoaded(data));
      } catch (error) {
        emit(WordsListFavoritsStateFail(error.toString()));
      }
    });
  }

  final WordMeaningsRepository wordMeaningsRepository;
}
