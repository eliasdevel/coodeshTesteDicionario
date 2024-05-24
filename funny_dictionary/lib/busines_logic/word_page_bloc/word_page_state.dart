import 'package:funny_dictionary/data/entities/word.dart';

abstract class WordPageState {}

class WordPageStateInitialized extends WordPageState {
  WordPageStateInitialized(this.word);

  final String word;
}

class WordPageStateLoaded extends WordPageState {
  WordPageStateLoaded(this.word, {required this.data, required this.favorite});
  String word;
  bool favorite;
  Word data;
}

class WordPageStateFail extends WordPageState {
  WordPageStateFail(this.word, {required this.error});
  String word;
  final String error;
}
