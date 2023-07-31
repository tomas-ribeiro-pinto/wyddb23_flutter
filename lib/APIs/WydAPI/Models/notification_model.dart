// To parse this JSON data, do
//
//     final sentNotification = sentNotificationFromJson(jsonString);

import 'dart:convert';

List<SentNotification> sentNotificationFromJson(String str) => List<SentNotification>.from(json.decode(str).map((x) => SentNotification.fromJson(x)));

String sentNotificationToJson(List<SentNotification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SentNotification {
    int id;
    String titlePt;
    String titleEn;
    String titleEs;
    String titleIt;
    String bodyPt;
    String bodyEn;
    String bodyEs;
    String bodyIt;
    String data;
    DateTime createdAt;
    DateTime updatedAt;

    SentNotification({
        required this.id,
        required this.titlePt,
        required this.titleEn,
        required this.titleEs,
        required this.titleIt,
        required this.bodyPt,
        required this.bodyEn,
        required this.bodyEs,
        required this.bodyIt,
        required this.data,
        required this.createdAt,
        required this.updatedAt,
    });

    factory SentNotification.fromJson(Map<String, dynamic> json) => SentNotification(
        id: json["id"],
        titlePt: json["title_pt"],
        titleEn: json["title_en"],
        titleEs: json["title_es"],
        titleIt: json["title_it"],
        bodyPt: json["body_pt"],
        bodyEn: json["body_en"],
        bodyEs: json["body_es"],
        bodyIt: json["body_it"],
        data: json["data"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title_pt": titlePt,
        "title_en": titleEn,
        "title_es": titleEs,
        "title_it": titleIt,
        "body_pt": bodyPt,
        "body_en": bodyEn,
        "body_es": bodyEs,
        "body_it": bodyIt,
        "data": data,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
