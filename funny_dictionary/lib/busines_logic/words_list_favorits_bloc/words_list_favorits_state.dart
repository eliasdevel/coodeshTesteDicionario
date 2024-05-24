abstract class WordsListFavoritsState {}

class WordsListFavoritsStateInitialized extends WordsListFavoritsState {}

class WordsListFavoritsStateLoaded extends WordsListFavoritsState {
  WordsListFavoritsStateLoaded(this.data);
  Map<String, dynamic> data;
}

class WordsListFavoritsStateFail extends WordsListFavoritsState {
  WordsListFavoritsStateFail(this.error);
  final String error;
}
