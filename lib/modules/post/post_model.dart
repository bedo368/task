class PostModel {
  int userId; // User ID of the post author
  int id; // Unique ID of the post
  String title; // Title of the post
  String body; // Body/content of the post

  // Constructor for creating a PostModel instance
  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory method to create a PostModel instance from a JSON map
  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  // Method to convert a PostModel instance to a JSON map
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
