// To parse this JSON data, do
//
//     final accommodation = accommodationFromJson(jsonString);

import 'dart:convert';

List<List<Accommodation>> accommodationFromJson(String str) => List<List<Accommodation>>.from(json.decode(str).map((x) => List<Accommodation>.from(x.map((x) => Accommodation.fromJson(x)))));

String accommodationToJson(List<List<Accommodation>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class Accommodation {
    String name;
    String location;
    String addressLine1;
    String addressLine2;
    String contact;
    String picture;
    String bodyPt;
    String bodyEn;
    String bodyEs;
    String bodyIt;
    dynamic createAt;
    DateTime updatedAt;

    Accommodation({
        required this.name,
        required this.location,
        required this.addressLine1,
        required this.addressLine2,
        required this.contact,
        required this.picture,
        required this.bodyPt,
        required this.bodyEn,
        required this.bodyEs,
        required this.bodyIt,
        this.createAt,
        required this.updatedAt,
    });

    factory Accommodation.fromJson(Map<String, dynamic> json) => Accommodation(
        name: json["name"],
        location: json["location"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        contact: json["contact"],
        picture: json["picture"],
        bodyPt: json["body_pt"],
        bodyEn: json["body_en"],
        bodyEs: json["body_es"],
        bodyIt: json["body_it"],
        createAt: json["create_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "contact": contact,
        "picture": picture,
        "body_pt": bodyPt,
        "body_en": bodyEn,
        "body_es": bodyEs,
        "body_it": bodyIt,
        "create_at": createAt,
        "updated_at": updatedAt.toIso8601String(),
    };

    String getTranslatedDescriptionAttribute(String locale)
    {
      switch (locale) {
        case 'en':
          bodyEn ?? (bodyEn = "");
          return bodyEn.toString();
        case 'pt':
          bodyPt ?? (bodyPt = "");
          return bodyPt.toString();
        case 'es':
          bodyEs ?? (bodyEs = "");
          return bodyEs.toString();
        case 'it':
          bodyIt ?? (bodyIt = "");
          return bodyIt.toString();
      }

      bodyEn ?? (bodyEn = "");
      return bodyEn.toString();
    }
}
