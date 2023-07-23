// To parse this JSON data, do
//
//     final emergency = emergencyFromJson(jsonString);

import 'dart:convert';

List<List<Emergency>> emergencyFromJson(String str) => List<List<Emergency>>.from(json.decode(str).map((x) => List<Emergency>.from(x.map((x) => Emergency.fromJson(x)))));

String emergencyToJson(List<List<Emergency>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class Emergency {
    String titlePt;
    String titleEn;
    String titleEs;
    String titleIt;
    dynamic imageUrl;
    String bodyPt;
    String bodyEn;
    String bodyEs;
    String bodyIt;

    Emergency({
        required this.titlePt,
        required this.titleEn,
        required this.titleEs,
        required this.titleIt,
        this.imageUrl,
        required this.bodyPt,
        required this.bodyEn,
        required this.bodyEs,
        required this.bodyIt,
    });

    factory Emergency.fromJson(Map<String, dynamic> json) => Emergency(
        titlePt: json["title_pt"],
        titleEn: json["title_en"],
        titleEs: json["title_es"],
        titleIt: json["title_it"],
        imageUrl: json["image_url"],
        bodyPt: json["body_pt"],
        bodyEn: json["body_en"],
        bodyEs: json["body_es"],
        bodyIt: json["body_it"],
    );

    Map<String, dynamic> toJson() => {
        "title_pt": titlePt,
        "title_en": titleEn,
        "title_es": titleEs,
        "title_it": titleIt,
        "image_url": imageUrl,
        "body_pt": bodyPt,
        "body_en": bodyEn,
        "body_es": bodyEs,
        "body_it": bodyIt,
    };

    String getTranslatedTitleAttribute(String locale)
    {
      switch (locale) {
        case 'en':
          return titleEn.toString();
        case 'pt':
          return titlePt.toString();
        case 'es':
          return titleEs.toString();
        case 'it':
          return titleIt.toString();
      }

      return titleEn.toString();
    }

    String getTranslatedBodyAttribute(String locale)
    {
      switch (locale) {
        case 'en':
          return bodyEn.toString();
        case 'pt':
          return bodyPt.toString();
        case 'es':
          return bodyEs.toString();
        case 'it':
          return bodyIt.toString();
      }

      return bodyEn.toString();
    }
}
