import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:funny_dictionary/data/entities/meanings.dart';

ValueNotifier<int> _index = ValueNotifier(0);

class MeaningsWidget extends StatelessWidget {
  const MeaningsWidget({super.key, required this.meanings});
  final List<Meanings> meanings;

  List<String> _getDefinitions() {
    List<String> definitions = [];

    for (final meaning in meanings) {
      for (final definition in meaning.definitions!) {
        definitions.add("${meaning.partOfSpeech} - ${definition.definition}");
      }
    }
    return definitions;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> definitions = _getDefinitions();
    _index.value = 0;

    return ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, _, a) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Meanings',
                  style: TextStyle(fontSize: 25),
                ),
                IndexedStack(
                  index: _index.value,
                  children: definitions
                      .map<Widget>(
                        (d) => Text(d),
                      )
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: _index.value == 0
                            ? null
                            : () {
                                _index.value = _index.value - 1;
                              },
                        icon: const Icon(Icons.arrow_left)),
                    IconButton(
                        onPressed: _index.value < definitions.length - 1
                            ? () {
                                _index.value = _index.value + 1;
                              }
                            : null,
                        icon: const Icon(Icons.arrow_right))
                  ],
                )
              ],
            ),
          );
        });
  }
}
