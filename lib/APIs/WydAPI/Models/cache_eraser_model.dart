// To parse this JSON data, do
//
//     final cacheEraser = cacheEraserFromJson(jsonString);

import 'dart:convert';

List<CacheEraser> cacheEraserFromJson(String str) => List<CacheEraser>.from(json.decode(str).map((x) => CacheEraser.fromJson(x)));

String cacheEraserToJson(List<CacheEraser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CacheEraser {
    int id;
    DateTime createdAt;
    DateTime updatedAt;

    CacheEraser({
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CacheEraser.fromJson(Map<String, dynamic> json) => CacheEraser(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
