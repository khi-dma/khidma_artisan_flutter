import 'package:khidma_artisan_flutter/models/model.user.dart';

class CommentArtisanModel {
  int id;
  UserModel artisan;
  String comment;
  double ratingProject;

  CommentArtisanModel(
      {required this.id,
      required this.artisan,
      required this.comment,
      required this.ratingProject});

  factory CommentArtisanModel.fromJson(Map<String, dynamic> json) {
    return CommentArtisanModel(
      id: json['id'],
      artisan: UserModel.fromJson(json["UserClient"]),
      comment: json["comment"],
      ratingProject: double.parse(json["ratingProject"].toString()),
    );
  }
}
