import 'package:firebase_auth/firebase_auth.dart';

class UserClient {
  String name;
  String uidFirebase;
  int phoneNumber;
  int sexe;
  DateTime birthDate;
  String profilePicture;


  UserClient({
    required this.name,
    required this.uidFirebase,
    required this.phoneNumber,
    required this.sexe,
    required this.birthDate,
    required this.profilePicture,

  });

  static UserClient notNull = UserClient(name: "", uidFirebase: "", phoneNumber: 0, sexe: 1, birthDate: DateTime.now(), profilePicture: "");

  factory UserClient.fromJson(Map<String, dynamic> json) {
    return UserClient(
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