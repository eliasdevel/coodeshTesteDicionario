class Definitions {
  String? definition;
  List<String>? synonyms;
  List<String>? antonyms;

  Definitions({this.definition, this.synonyms, this.antonyms});

  Definitions.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    if (json['synonyms'] != null) {
      synonyms = <String>[];
      json['synonyms'].forEach((v) {
        synonyms!.add(v.toString());
      });
    }
    if (json['antonyms'] != null) {
      antonyms = <String>[];
      json['antonyms'].forEach((v) {
        antonyms!.add(v.toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;
    if (synonyms != null) {
      data['synonyms'] = synonyms!.map((v) => v).toList();
    }
    if (antonyms != null) {
      data['antonyms'] = antonyms!.map((v) => v).toList();
    }
    return data;
  }
}