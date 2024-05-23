abstract class WordsListState {}

class WordsListStateInitialized extends WordsListState {}

class WordsListStateLoaded extends WordsListState {
  WordsListStateLoaded(this.data);
  Map<String, dynamic> data;
}

class WordsListStateFail extends WordsListState {
  WordsListStateFail(this.error);
  final String error;
}
