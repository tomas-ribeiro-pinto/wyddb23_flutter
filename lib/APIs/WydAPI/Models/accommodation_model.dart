// To parse this JSON data, do
//
//     final accommodation = accommodationFromJson(jsonString);

import 'dart:convert';

List<Accommodation> accommodationFromJson(String str) => List<Accommodation>.from(json.decode(str).map((x) => Accommodation.fromJson(x)));

String accommodationToJson(List<Accommodation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Accommodation {
    int id;
    String name;
    String location;
    String addressLine1;
    String addressLine2;
    String contact;
    dynamic descriptionEn;
    dynamic descriptionPt;
    String picture;
    DateTime createdAt;
    DateTime updatedAt;

    Accommodation({
        required this.id,
        required this.name,
        required this.location,
        required this.addressLine1,
        required this.addressLine2,
        required this.contact,
        this.descriptionEn,
        this.descriptionPt,
        required this.picture,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Accommodation.fromJson(Map<String, dynamic> json) => Accommodation(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        contact: json["contact"],
        descriptionEn: json["description_en"],
        descriptionPt: json["description_pt"],
        picture: json["picture"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "contact": contact,
        "description_en": descriptionEn,
        "description_pt": descriptionPt,
        "picture": picture,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };

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
