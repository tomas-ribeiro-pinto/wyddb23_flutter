// To parse this JSON data, do
//
//     final day = dayFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<Day> dayFromJson(String str) => List<Day>.from(json.decode(str).map((x) => Day.fromJson(x)));

String dayToJson(List<Day> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Day {
    int id;
    DateTime day;
    DateTime createdAt;
    DateTime updatedAt;
    List<Entry> entries;

    Day({
        required this.id,
        required this.day,
        required this.createdAt,
        required this.updatedAt,
        required this.entries,
    });

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        id: json["id"],
        day: DateTime.parse(json["day"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        entries: List<Entry>.from(json["entries"].map((x) => Entry.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "day": "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "entries": List<dynamic>.from(entries.map((x) => x.toJson())),
    };
}

class Entry {
    int id;
    int dayId;
    String titleEn;
    String? descriptionEn;
    String titlePt;
    String? descriptionPt;
    String location;
    DateTime startTime;
    DateTime endTime;
    DateTime createdAt;
    DateTime updatedAt;

    Entry({
        required this.id,
        required this.dayId,
        required this.titleEn,
        required this.descriptionEn,
        required this.titlePt,
        required this.descriptionPt,
        required this.location,
        required this.startTime,
        required this.endTime,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        id: json["id"],
        dayId: json["day_id"],
        titleEn: json["title_en"],
        descriptionEn: json["description_en"],
        titlePt: json["title_pt"],
        descriptionPt: json["description_pt"],
        location: json["location"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "day_id": dayId,
        "title_en": titleEn,
        "description_en": descriptionEn,
        "title_pt": titlePt,
        "description_pt": descriptionPt,
        "location": location,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };

    String getTranslatedTitleAttribute(String locale)
    {
      switch (locale) {
        case 'en':
          return titleEn;
        case 'pt':
          return titlePt;
      }

      return titleEn;
    }

    String getTranslatedDescriptionAttribute(String locale)
    {
      switch (locale) {
        case 'en':
          descriptionEn ?? (descriptionEn = "");
          return descriptionEn.toString();
        case 'pt':
          descriptionPt ?? (descriptionPt = "");
          return descriptionPt.toString();
      }

      descriptionEn ?? (descriptionEn = "");
      return descriptionEn.toString();
    }
}
