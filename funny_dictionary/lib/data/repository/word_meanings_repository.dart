import 'package:funny_dictionary/data/entities/word.dart';
import 'package:funny_dictionary/data/provider/local_word_meanings_provider.dart';
import 'package:funny_dictionary/data/provider/remote_word_meanings_provider.dart';

class WordMeaningsRepository {
  WordMeaningsRepository(
      this.remoteWordMeaningsProvider, this.localWordMeaningsProvider);
  final RemoteWordMeaningsProvider remoteWordMeaningsProvider;
  final LocalWordMeaningsProvider localWordMeaningsProvider;
  Future<Word> getWordDetails(String word) async {
    //Todo cache and try to get local
    // retrive favorite
    Word? localWord = await localWordMeaningsProvider.getLocalMeanings(word);
    if (localWord != null) {
      return localWord;
    }
    Word remoteWord = await remoteWordMeaningsProvider.getRemoteMeanings(word);

    await localWordMeaningsProvider.saveLocal(remoteWord);

    return remoteWord;
  }
}
