// To parse this JSON data, do
//
//     final contact = contactFromJson(jsonString);

import 'dart:convert';

List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
    int id;
    String person;
    dynamic descriptionEn;
    String descriptionPt;
    dynamic descriptionEs;
    dynamic descriptionIt;
    String contact;
    DateTime createdAt;
    DateTime updatedAt;

    Contact({
        required this.id,
        required this.person,
        this.descriptionEn,
        required this.descriptionPt,
        this.descriptionEs,
        this.descriptionIt,
        required this.contact,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        person: json["person"],
        descriptionEn: json["description_en"],
        descriptionPt: json["description_pt"],
        descriptionEs: json["description_es"],
        descriptionIt: json["description_it"],
        contact: json["contact"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "person": person,
        "description_en": descriptionEn,
        "description_pt": descriptionPt,
        "description_es": descriptionEs,
        "description_it": descriptionIt,
        "contact": contact,
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
        case 'es':
          descriptionEs ?? (descriptionEs = "");
          return descriptionEs.toString();
        case 'it':
          descriptionIt ?? (descriptionIt = "");
          return descriptionIt.toString();
      }

      descriptionEn ?? (descriptionEn = "");
      return descriptionEn.toString();
    }
}
