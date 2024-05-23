import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funny_dictionary/busines_logic/word_page_bloc/word_page_bloc.dart';
import 'package:funny_dictionary/data/entities/phonetics.dart';
import 'package:funny_dictionary/data/repository/word_meanings_repository.dart';
import 'package:just_audio/just_audio.dart';

class WordPageBloc extends Bloc<WordPageEvent, WordPageState> {
  WordMeaningsRepository wordMeaningsRepository;
  String word;
  final player = AudioPlayer();
  WordPageBloc(this.word, {required this.wordMeaningsRepository})
      : super(WordPageStateInitialized('')) {
    on<WordPageEventInit>((event, emit) async {
      try {
        emit(WordPageStateInitialized(event.word));
        if (event.word.isEmpty) {
          return;
        }
        final data = await wordMeaningsRepository.getWordDetails(event.word);
        emit(WordPageStateLoaded(event.word, data: data));
      } on DioException catch (exception) {
        log(exception.type.toString());

        emit(WordPageStateFail(event.word, error: exception.toString()));
      }
    });

    on<WordPageEventPlayAudio>((event, emit) async {
      Phonetics phonetics =
          event.word.phonetics!.firstWhere((e) => e.audio!.isNotEmpty);
      await player.setUrl(phonetics.audio!);
      player.play();
    });
  }
}
