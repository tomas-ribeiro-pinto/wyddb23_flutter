// To parse this JSON data, do
//
//     final prayer = prayerFromJson(jsonString);

import 'dart:convert';

List<List<Prayer>> prayerFromJson(String str) => List<List<Prayer>>.from(json.decode(str).map((x) => List<Prayer>.from(x.map((x) => Prayer.fromJson(x)))));

String prayerToJson(List<List<Prayer>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class Prayer {
    Day day;
    int? orderIndex;
    String? titlePt;
    String? titleEn;
    String? titleEs;
    String? titleIt;
    String? bodyPt;
    String? bodyEn;
    String? bodyEs;
    String? bodyIt;

    Prayer({
        required this.day,
        required this.orderIndex,
        required this.titlePt,
        required this.titleEn,
        required this.titleEs,
        required this.titleIt,
        required this.bodyPt,
        required this.bodyEn,
        required this.bodyEs,
        required this.bodyIt,
    });

    factory Prayer.fromJson(Map<String, dynamic> json) => Prayer(
        day: Day.fromJson(json["day"]),
        orderIndex: json["order_index"],
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
        "day": day.toJson(),
        "order_index": orderIndex,
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

class Day {
    int id;
    DateTime day;
    DateTime createdAt;
    DateTime updatedAt;

    Day({
        required this.id,
        required this.day,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        id: json["id"],
        day: DateTime.parse(json["day"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "day": "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
