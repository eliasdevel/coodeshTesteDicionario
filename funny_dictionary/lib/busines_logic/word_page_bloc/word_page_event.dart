import 'package:funny_dictionary/data/entities/word.dart';

abstract class WordPageEvent {}

class WordPageEventInit extends WordPageEvent {
  WordPageEventInit(this.word);
  final String word;
}

class WordPageEventFavoriteWord extends WordPageEvent {
  WordPageEventFavoriteWord(this.word, this.favorite);
  final bool favorite;
  final Word word;
}
