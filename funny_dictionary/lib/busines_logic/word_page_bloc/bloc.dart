import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/word_page_bloc/word_page_bloc.dart';

import 'package:funny_dictionary/data/repository/word_meanings_repository.dart';
import 'package:storage/storage.dart';

class WordPageBloc extends Bloc<WordPageEvent, WordPageState> {
  WordMeaningsRepository wordMeaningsRepository;

  String word;

  WordPageBloc(this.word, {required this.wordMeaningsRepository})
      : super(WordPageStateInitialized('')) {
    on<WordPageEventInit>(
      (event, emit) async {
        try {
          emit(WordPageStateInitialized(event.word));
          if (event.word.isEmpty) {
            return;
          }
          final data = await wordMeaningsRepository.getWordDetails(event.word);

          emit(WordPageStateLoaded(event.word,
              data: data, favorite: data.favorite ?? false));
        } on DioException catch (exception) {
          emit(WordPageStateFail(event.word, error: exception.toString()));
        }
      },
    );

    on<WordPageEventFavoriteWord>(
      (event, emit) async {
        try {
          final bool favorite = !(event.word.favorite ?? false);

          //save in database
          if (favorite) {
            await Storage.save(StorageTable.favoriteWords, {
              'name': event.word.word,
              'insert_time': DateTime.now().millisecondsSinceEpoch / 1000
            });
          } else {
            await Storage.delete(StorageTable.favoriteWords,
                filter: StorageFilter(
                    columns: ['name'], arguments: [event.word.word]));
          }

          emit(WordPageStateLoaded(event.word.word!,
              data: event.word, favorite: favorite));
        } on DioException catch (exception) {
          emit(
              WordPageStateFail(event.word.word!, error: exception.toString()));
        }
      },
    );
  }
}
