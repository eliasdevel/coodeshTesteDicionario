abstract class WordsListHistoryState {}

class WordsListHistoryStateInitialized extends WordsListHistoryState {}

class WordsListHistoryStateLoaded extends WordsListHistoryState {
  WordsListHistoryStateLoaded(this.data);
  Map<String, dynamic> data;
}

class WordsListHistoryStateFail extends WordsListHistoryState {
  WordsListHistoryStateFail(this.error);
  final String error;
}
