import 'dart:convert';

import 'dart:typed_data';
import 'package:funny_dictionary/data/entities/word.dart';
import 'package:storage/storage.dart';

class LocalWordMeaningsProvider {
  Future<Word?> getLocalMeanings(String word) async {
    final filter = StorageFilter(columns: ['name'], arguments: [word]);
    final data = await Storage.query(StorageTable.cachedWords, filter: filter);

    if (data != null && data.isNotEmpty) {
      final favoriteWords =
          await Storage.query(StorageTable.favoriteWords, filter: filter);

      String jsonString = String.fromCharCodes(
              List<int>.from(data.first['server_data'] as List))
          .toString();

      return Word.fromJson(jsonDecode(jsonString),
          varFavorite: favoriteWords?.isNotEmpty ?? false);
    }

    return null;
  }

  Future<Map<String, dynamic>> getLocalWords() async {
    return {
      for (var v in (await Storage.query(StorageTable.cachedWords)) ?? [])
        v['name']: 1
    };
  }

  Future<Map<String, dynamic>> getLocalFavorits() async {
    return {
      for (var v in (await Storage.query(StorageTable.favoriteWords)) ?? [])
        v['name']: 1
    };
  }

  Future<void> saveLocal(Word word) async {
    final Uint8List serverData =
        Uint8List.fromList(jsonEncode(word.toJson()).codeUnits);

    await Storage.save(StorageTable.cachedWords, {
      'name': word.word,
      'server_data': serverData,
      'insert_time': DateTime.now().millisecondsSinceEpoch / 1000
    });
  }
}
