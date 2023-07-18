// To parse this JSON data, do
//
//     final symMap = symMapFromJson(jsonString);

import 'dart:convert';

SymMap symMapFromJson(String str) => SymMap.fromJson(json.decode(str));

String symMapToJson(SymMap data) => json.encode(data.toJson());

class SymMap {
    int id;
    String url;
    DateTime createdAt;
    DateTime updatedAt;

    SymMap({
        required this.id,
        required this.url,
        required this.createdAt,
        required this.updatedAt,
    });

    factory SymMap.fromJson(Map<String, dynamic> json) => SymMap(
        id: json["id"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
