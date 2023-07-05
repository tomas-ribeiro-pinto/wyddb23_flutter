// To parse this JSON data, do
//
//     final visit = visitFromJson(jsonString);

import 'dart:convert';

List<Visit> visitFromJson(String str) => List<Visit>.from(json.decode(str).map((x) => Visit.fromJson(x)));

String visitToJson(List<Visit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Visit {
    int id;
    String name;
    String addressLine1;
    String addressLine2;
    String descriptionEn;
    String descriptionPt;
    String picture;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Visit({
        required this.id,
        required this.name,
        required this.addressLine1,
        required this.addressLine2,
        required this.descriptionEn,
        required this.descriptionPt,
        required this.picture,
        required this.createdAt,
        required this.updatedAt,
        this.deletedAt,
    });

    factory Visit.fromJson(Map<String, dynamic> json) => Visit(
        id: json["id"],
        name: json["name"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        descriptionEn: json["description_en"],
        descriptionPt: json["description_pt"],
        picture: json["picture"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "description_en": descriptionEn,
        "description_pt": descriptionPt,
        "picture": picture,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
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
