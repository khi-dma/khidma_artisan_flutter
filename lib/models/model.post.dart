import '../data/fonc.data.dart';
import 'model.client.dart';
import 'package:get/get.dart';

class PostModel {
  int idPost;
  String title;
  String description;
  String city;
  String municipal;
  int idService;
  int idClient;
  String date;
  int requests;
  String urlPic;
  String pathPic;
  int newRequests;
  DateTime createdAt;
  DateTime updatedAt;
  UserClient userClient;
  Rx<bool> saved;
  bool requested;

  PostModel({
    required this.idPost,
    required this.title,
    required this.description,
    required this.city,
    required this.municipal,
    required this.idService,
    required this.idClient,
    required this.date,
    required this.requests,
    required this.urlPic,
    required this.pathPic,
    required this.newRequests,
    required this.createdAt,
    required this.updatedAt,
    required this.userClient,
    required this.saved,
    required this.requested
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      idPost: json['idPost'],
      title: json['title'],
      description: json['description'],
      city: json['city'],
      municipal: json['municipal'],
      idService: json['idService'],
      idClient: json['idClient'],
      date: dateToString(json["date"]),
      requests: json['requests'],
      urlPic: json['urlPic'],
      pathPic: json['pathPic'],
      newRequests: json['newRequests'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userClient: UserClient.fromJson(json['UserClient']),
      requested: false,
      saved: false.obs,
    );
  }

  @override
  String toString() {
    return 'PostModel{idPost: $idPost, title: $title, description: $description, city: $city, municipal: $municipal, idService: $idService, idClient: $idClient, date: $date, requests: $requests, urlPic: $urlPic, pathPic: $pathPic, newRequests: $newRequests, createdAt: $createdAt, updatedAt: $updatedAt, userClient: $userClient}';
  }
}
