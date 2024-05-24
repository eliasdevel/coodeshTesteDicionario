import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:funny_dictionary/data/entities/word.dart';
import 'package:just_audio/just_audio.dart';

class WordPlayer extends StatelessWidget {
  final Word word;
  WordPlayer({super.key, required this.word});
  final player = AudioPlayer();

  String? _getAudioUrlFromWord() {
    return word.phonetics
        ?.firstWhere(
          (e) => e.audio!.contains("http"),
          orElse: () => Phonetics(audio: null),
        )
        .audio;
  }

  @override
  Widget build(BuildContext context) {
    String? url = _getAudioUrlFromWord();

    if (url != null) {
      player.setUrl(url);
    }

    return StreamBuilder(
        stream: player.playerStateStream,
        builder: (_, a) {
          if (a.data == null) {
            return const CircularProgressIndicator();
          }

          if (a.data?.playing == true) {
            return IconButton(
                enableFeedback: url!.isNotEmpty,
                onPressed: url.isNotEmpty
                    ? () {
                        player.stop();

                        player.setUrl(url);
                      }
                    : null,
                icon: const Icon(Icons.stop));
          } else {
            return IconButton(
              enableFeedback: false,
              onPressed: url != null ? () => player.play() : null,
              icon: const Icon(Icons.play_arrow),
            );
          }
        });
  }
}
