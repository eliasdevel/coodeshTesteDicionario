import 'dart:convert';

import 'package:flutter/services.dart';

class LocalDictionaryProvider {
  Future<Map<String, dynamic>> getDictionary() async {
    return jsonDecode(
      await rootBundle.loadString('words_dictionary.json'),
    );
  }
}
