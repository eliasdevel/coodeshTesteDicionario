import 'package:funny_dictionary/data/provider/local_dictionary_provider.dart';
import 'package:funny_dictionary/data/provider/local_word_meanings_provider.dart';

class WordsListRepository {
  WordsListRepository(
      {required this.localDictionaryProvider,
      required this.localWordMeaningsProvider});
  LocalDictionaryProvider localDictionaryProvider;
  LocalWordMeaningsProvider localWordMeaningsProvider;

  Future<Map<String, dynamic>> getWordsList() async {
    return localDictionaryProvider.getDictionary();
  }

  Future<Map<String, dynamic>> getWordsListHistory() async {
    return localWordMeaningsProvider.getLocalWords();
  }

  Future<Map<String, dynamic>> getWordsListFavorits() async {
    return localWordMeaningsProvider.getLocalFavorits();
  }
}
