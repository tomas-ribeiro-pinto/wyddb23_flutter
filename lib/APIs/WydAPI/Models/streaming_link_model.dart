// To parse this JSON data, do
//
//     final streamingLink = streamingLinkFromJson(jsonString);

import 'dart:convert';

StreamingLink streamingLinkFromJson(String str) => StreamingLink.fromJson(json.decode(str));

String streamingLinkToJson(StreamingLink data) => json.encode(data.toJson());

class StreamingLink {
    int id;
    String name;
    String? url;
    DateTime createdAt;
    DateTime updatedAt;

    StreamingLink({
        required this.id,
        required this.name,
        required this.url,
        required this.createdAt,
        required this.updatedAt,
    });

    factory StreamingLink.fromJson(Map<String, dynamic> json) => StreamingLink(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
