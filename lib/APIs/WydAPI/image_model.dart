// To parse this JSON data, do
//
//     final image = imageFromJson(jsonString);

import 'dart:convert';

List<Image> imageFromJson(String str) => List<Image>.from(json.decode(str).map((x) => Image.fromJson(x)));

String imageToJson(List<Image> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Image {
    String imageUrl;

    Image({
        required this.imageUrl,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
    };
}