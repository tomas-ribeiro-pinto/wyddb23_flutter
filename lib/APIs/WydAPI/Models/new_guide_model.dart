// To parse this JSON data, do
//
//     final newGuide = newGuideFromJson(jsonString);

import 'dart:convert';

List<List<NewGuide>> newGuideFromJson(String str) => List<List<NewGuide>>.from(json.decode(str).map((x) => List<NewGuide>.from(x.map((x) => NewGuide.fromJson(x)))));

String newGuideToJson(List<List<NewGuide>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class NewGuide {
    String titlePt;
    String titleEn;
    String titleEs;
    String titleIt;
    String bodyPt;
    String bodyEn;
    String bodyEs;
    String bodyIt;

    NewGuide({
        required this.titlePt,
        required this.titleEn,
        required this.titleEs,
        required this.titleIt,
        required this.bodyPt,
        required this.bodyEn,
        required this.bodyEs,
        required this.bodyIt,
    });

    factory NewGuide.fromJson(Map<String, dynamic> json) => NewGuide(
        titlePt: json["title_pt"],
        titleEn: json["title_en"],
        titleEs: json["title_es"],
        titleIt: json["title_it"],
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