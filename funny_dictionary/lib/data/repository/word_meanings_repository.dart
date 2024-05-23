import 'package:funny_dictionary/data/entities/word.dart';
import 'package:funny_dictionary/data/provider/remote_word_meanings_provider.dart';

class WordMeaningsRepository {
  WordMeaningsRepository(this.remoteWordMeaningsProvider);
  final RemoteWordMeaningsProvider remoteWordMeaningsProvider;
  Future<Word> getWordDetails(String word) async {
    //Todo cache and try to get local
    return remoteWordMeaningsProvider.getRemoteMeanings(word);
  }
}
