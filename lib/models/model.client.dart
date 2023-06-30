import 'package:firebase_auth/firebase_auth.dart';

class ClientModel {
  String name;
  String uidFirebase;
  int phoneNumber;
  int sexe;
  DateTime birthDate;
  String profilePicture;

  String? addressCrypto;


  ClientModel({
    this.addressCrypto,
    required this.name,
    required this.uidFirebase,
    required this.phoneNumber,
    required this.sexe,
    required this.birthDate,
    required this.profilePicture,

  });

  static ClientModel notNull = ClientModel(name: "", uidFirebase: "", phoneNumber: 0, sexe: 1, birthDate: DateTime.now(), profilePicture: "");

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      addressCrypto: json["addressCrypto"],
      name: (json['lastName']?? json["name"])+" "+( json['firstName']??""),
      uidFirebase: json['uidFirebase'],
      phoneNumber: json['phoneNumber'],
      sexe: json['sexe'],
      birthDate: DateTime.parse(json['birthDate']),
      profilePicture: json['profilePicture']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uidFirebase': uidFirebase,
      'phoneNumber': phoneNumber,
      'sexe': sexe,
      'birthDate': birthDate.toIso8601String(),
      'profilePicture': profilePicture,

    };
  }

  @override
  String toString() {
    return 'UserClient{name: $name, uidFirebase: $uidFirebase, phoneNumber: $phoneNumber, sexe: $sexe, birthDate: $birthDate, profilePicture: $profilePicture}';
  }
}