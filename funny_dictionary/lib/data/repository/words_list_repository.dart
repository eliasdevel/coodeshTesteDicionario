import 'package:funny_dictionary/data/provider/local_dictionary_provider.dart';

class WordsListRepository {
  WordsListRepository({required this.localDictionaryProvider});
  LocalDictionaryProvider localDictionaryProvider;

  Future<Map<String, dynamic>> getWordsList() async {
    return localDictionaryProvider.getDictionary();
  }
}
