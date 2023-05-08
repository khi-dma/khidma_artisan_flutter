import 'package:khidma_artisan_flutter/controllers/LocalController/controller.local.dart';
import 'package:khidma_artisan_flutter/data/const.data.dart';
import 'package:khidma_artisan_flutter/models/model.service.dart';

class UserModel {
  String firstName;
  String lastName;
  String phoneNumber;
  String tokenNotification;
  String profilePicture;
  String city;
  String sexe;
  String birthDate;
  String municipal;
  ServiceModel service;
  bool graduated;
  bool available;
  String uidFirebase;
  String rating;

  UserModel(
      {required this.uidFirebase,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.tokenNotification,
      required this.profilePicture,
      required this.city,
      required this.sexe,
      required this.birthDate,
      required this.available,
      required this.municipal,
      required this.graduated,
      required this.service,required this.rating});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    ServiceModel service = services.where((service) => service.id==json['service']).toList().first;
    return UserModel(
      firstName:json['firstName'],
      lastName: json['lastName'],
      phoneNumber:"+213" +  json['phoneNumber'].toString(),
      tokenNotification:"",
      profilePicture: json['profilePicture']??"",
      city: json['city'],
      sexe: json['sexe']=="0"?"Homme":"Femme",
      birthDate: json['birthDate'].toString(),
      service: service,
      municipal: json["municipal"],
      available: json["available"],
      graduated: json["graduate"],
      uidFirebase: LocalController.getUid(),
      rating :  (json["rating"] ?? 0).toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['notificationToken'] = tokenNotification;
    data['profilePicture'] = profilePicture;
    data['city'] = city;
    data['sexe'] = sexe;
    data['birthDate'] = birthDate;
    data['graduated'] = graduated.toString();
    data["available"] = available.toString();
    data["municipal"] = municipal;
    data["service"] = service.id.toString();
    data['uidFirebase'] = uidFirebase;
    return data;
  }
}
