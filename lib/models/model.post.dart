import 'package:firebase_auth/firebase_auth.dart';

import '../data/fonc.data.dart';
import 'model.client.dart';
import 'package:get/get.dart';

import 'model.offer.dart';
import 'model.request.dart';

class PostModel {
  int idPost;
  String title;
  String description;
  String city;
  String municipal;
  int idService;
  int idClient;
  String date;
  int requestsNumber;
  String urlPic;
  String pathPic;
  int newRequests;
  ClientModel userClient;
  Rx<bool> saved;
  Rx<bool> requested;
  bool offered;
  OfferModel offer;
  List<RequestModel> requests;
  List<OfferModel> offers;
  RequestModel request;

  PostModel({
    required this.offers,
    required this.requests,
    required this.idPost,
    required this.title,
    required this.description,
    required this.city,
    required this.municipal,
    required this.idService,
    required this.idClient,
    required this.date,
    required this.requestsNumber,
    required this.urlPic,
    required this.pathPic,
    required this.newRequests,
    required this.userClient,
    required this.saved,
    required this.requested,
    this.offered = false,
    this.offer = OfferModel.notNull,
    this.request = RequestModel.notNull,
  });

  static PostModel notNull = PostModel(
    idPost: 0,
    title: '',
    description: '',
    city: '',
    municipal: '',
    idService: 0,
    idClient: 0,
    date: '',
    requestsNumber: 0,
    urlPic: '',
    pathPic: '',
    newRequests: 0,
    saved: false.obs,
    requested: false.obs,
    offered: false,
    offer: OfferModel.notNull,
    requests: [],
    offers: [],
    request: RequestModel.notNull,
    userClient: ClientModel.notNull,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      requests:json["Requests"]==null?[]: json["Requests"]
          .map<RequestModel>((json) => RequestModel.fromJson(json))
          .toList(),
      offers:json["Offers"]==null?[]: json["Offers"]
          .map<OfferModel>((json) => OfferModel.fromJson(json))
          .toList(),
      idPost: json['idPost'],
      title: json['title'],
      description: json['description'],
      city: json['city'],
      municipal: json['municipal'],
      idService: json['idService'],
      idClient: json['idClient'],
      date: dateToStringPost(json["date"]),
      requestsNumber: json['requests'],
      urlPic: json['urlPic'],
      pathPic: json['pathPic'],
      newRequests: json['newRequests'],
      userClient:json["UserClient"]==null?ClientModel.notNull: ClientModel.fromJson(json['UserClient']),
      requested: false.obs,
      saved: false.obs,
    );
  }

  @override
  String toString() {
    return 'PostModel{idPost: $idPost, title: $title, description: $description, city: $city, municipal: $municipal, idService: $idService, idClient: $idClient, date: $date, requestsNumber: $requestsNumber, urlPic: $urlPic, pathPic: $pathPic, newRequests: $newRequests, userClient: $userClient, saved: $saved, requested: $requested, offered: $offered, offer: $offer, request: $request}';
  }
}
