// To parse this JSON data, do
//
//     final symMap = symMapFromJson(jsonString);

import 'dart:convert';

SymMap symMapFromJson(String str) => SymMap.fromJson(json.decode(str));

String symMapToJson(SymMap data) => json.encode(data.toJson());

class SymMap {
    int id;
    String urlPt;
    dynamic urlEn;
    dynamic urlEs;
    dynamic urlIt;
    DateTime createdAt;
    DateTime updatedAt;

    SymMap({
        required this.id,
        required this.urlPt,
        this.urlEn,
        this.urlEs,
        this.urlIt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory SymMap.fromJson(Map<String, dynamic> json) => SymMap(
        id: json["id"],
        urlPt: json["url_pt"],
        urlEn: json["url_en"],
        urlEs: json["url_es"],
        urlIt: json["url_it"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url_pt": urlPt,
        "url_en": urlEn,
        "url_es": urlEs,
        "url_it": urlIt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };

    String getTranslatedMap(String locale)
    {
      switch (locale) {
        case 'en':
          return urlEn.toString();
        case 'pt':
          return urlPt.toString();
        case 'es':
          return urlEs.toString();
        case 'it':
          return urlIt.toString();
      }

      return urlEn.toString();
    }
}
