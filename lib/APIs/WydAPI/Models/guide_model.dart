// To parse this JSON data, do
//
//     final guide = guideFromJson(jsonString);

import 'dart:convert';

List<Guide> guideFromJson(String str) => List<Guide>.from(json.decode(str).map((x) => Guide.fromJson(x)));

String guideToJson(List<Guide> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Guide {
    int id;
    String titlePt;
    String titleEn;
    String titleEs;
    String titleIt;
    String assetUrl;
    DateTime createdAt;
    DateTime updatedAt;

    Guide({
        required this.id,
        required this.titlePt,
        required this.titleEn,
        required this.titleEs,
        required this.titleIt,
        required this.assetUrl,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Guide.fromJson(Map<String, dynamic> json) => Guide(
        id: json["id"],
        titlePt: json["title_pt"],
        titleEn: json["title_en"],
        titleEs: json["title_es"],
        titleIt: json["title_it"],
        assetUrl: json["asset_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title_pt": titlePt,
        "title_en": titleEn,
        "title_es": titleEs,
        "title_it": titleIt,
        "asset_url": assetUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };

    String getTranslatedTitleAttribute(String locale)
    {
      switch (locale) {
        case 'en':
          return titleEn ?? "";
        case 'pt':
          return titlePt ?? "";
        case 'pt':
          return titleEs ?? "";
        case 'pt':
          return titleIt ?? "";
      }

      return  titleEn ?? "";
    }
}
