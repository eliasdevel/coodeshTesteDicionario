import 'package:funny_dictionary/data/entities/word.dart';

abstract class WordPageEvent {}

class WordPageEventInit extends WordPageEvent {
  WordPageEventInit(this.word);
  final String word;
}

class WordPageEventPlayAudio extends WordPageEvent {
  WordPageEventPlayAudio(this.word);
  final Word word;
}
