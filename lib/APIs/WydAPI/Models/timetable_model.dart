// To parse this JSON data, do
//
//     final timetable = timetableFromJson(jsonString);

import 'dart:convert';

Map<String, Timetable> timetableFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Timetable>(k, Timetable.fromJson(v)));

String timetableToJson(Map<String, Timetable> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Timetable {
    int id;
    String titleEn;
    String titlePt;
    String titleEs;
    String titleIt;
    String? descriptionEn;
    String? descriptionPt;
    String? descriptionEs;
    String? descriptionIt;
    String location;
    DateTime startTime;
    DateTime? endTime;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;

    Timetable({
        required this.id,
        required this.titleEn,
        required this.titlePt,
        required this.titleEs,
        required this.titleIt,
        this.descriptionEn,
        this.descriptionPt,
        this.descriptionEs,
        this.descriptionIt,
        required this.location,
        required this.startTime,
        required this.endTime,
        this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        id: json["id"],
        titleEn: json["title_en"],
        titlePt: json["title_pt"],
        titleEs: json["title_es"],
        titleIt: json["title_it"],
        descriptionEn: json["description_en"],
        descriptionPt: json["description_pt"],
        descriptionEs: json["description_es"],
        descriptionIt: json["description_it"],
        location: json["location"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: json["end_time"] != null ? DateTime.parse(json["end_time"]) : null,
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title_en": titleEn,
        "title_pt": titlePt,
        "title_es": titleEs,
        "title_it": titleIt,
        "description_en": descriptionEn,
        "description_pt": descriptionPt,
        "description_es": descriptionEs,
        "description_it": descriptionIt,
        "location": location,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "deleted_at": deletedAt,
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

    String getTranslatedDescriptionAttribute(String locale)
    {
      switch (locale) {
        case 'en':
          return descriptionEn.toString();
        case 'pt':
          return descriptionPt.toString();
        case 'es':
          return descriptionEs.toString();
        case 'it':
          return descriptionIt.toString();
      }

      return descriptionEn.toString();
    }
}