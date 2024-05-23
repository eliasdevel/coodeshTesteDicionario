import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:funny_dictionary/data/entities/word.dart';

class RemoteWordMeaningsProvider {
  Future<Word> getRemoteMeanings(String word) async {
    final response = await Dio()
        .get<String>("https://api.dictionaryapi.dev/api/v2/entries/en/$word");

    if (response.data == null) {
      throw Exception('Null Returned From server');
    }

    return Word.fromJson(jsonDecode(response.data!)[0]);
  }
}
