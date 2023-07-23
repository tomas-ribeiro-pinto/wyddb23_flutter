// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'dart:convert';

List<Story> storyFromJson(String str) => List<Story>.from(json.decode(str).map((x) => Story.fromJson(x)));

String storyToJson(List<Story> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Story {
    int id;
    String title;
    String imageUrl;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    List<StoryElement> stories;

    Story({
        required this.id,
        required this.title,
        required this.imageUrl,
        required this.createdAt,
        required this.updatedAt,
        this.deletedAt,
        required this.stories,
    });

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        stories: List<StoryElement>.from(json["stories"].map((x) => StoryElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
    };
}

class StoryElement {
    int id;
    int storyGroupId;
    String contentUrl;
    int isVideo;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    StoryElement({
        required this.id,
        required this.storyGroupId,
        required this.contentUrl,
        required this.isVideo,
        required this.createdAt,
        required this.updatedAt,
        this.deletedAt,
    });

    factory StoryElement.fromJson(Map<String, dynamic> json) => StoryElement(
        id: json["id"],
        storyGroupId: json["story_group_id"],
        contentUrl: json["content_url"],
        isVideo: json["is_video"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "story_group_id": storyGroupId,
        "content_url": contentUrl,
        "is_video": isVideo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
