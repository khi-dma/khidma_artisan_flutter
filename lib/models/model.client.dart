import 'package:firebase_auth/firebase_auth.dart';

class ClientModel {
  String name;
  String uidFirebase;
  int phoneNumber;
  int sexe;
  DateTime birthDate;
  String profilePicture;
  Map<int, int> stars;
  Map<ProjectsCountCase, int> projectsNumber;
  String? addressCrypto;
  int starsNumber;
  String rating;


  ClientModel({
    required this.rating,
    required this.starsNumber,
    required this.stars,
    required this.projectsNumber,
    this.addressCrypto,
    required this.name,
    required this.uidFirebase,
    required this.phoneNumber,
    required this.sexe,
    required this.birthDate,
    required this.profilePicture,
  });

  static ClientModel notNull = ClientModel(
      name: "",
      uidFirebase: "",
      phoneNumber: 0,
      sexe: 1,
      birthDate: DateTime.now(),
      profilePicture: "",
      stars: {},
      projectsNumber: {},
      starsNumber: 0,
      rating: '0');

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    int numberStars = 0;

    Map<int, int> stars = {
      1: json["oneStarCount"] ?? 0,
      2: json["twoStarCount"] ?? 0,
      3: json["threeStarCount"] ?? 0,
      4: json["fourStarCount"] ?? 0,
      5: json["fiveStarCount"] ?? 0,
      0: json["zeroStarCount"] ?? 0,
    };

    Map<ProjectsCountCase, int> projectsNumber = {
      ProjectsCountCase.projectsCount: json["projectsCount"] ?? 0,
      ProjectsCountCase.projectsCountFinished:
      json["projectsCountFinished"] ?? 0,
      ProjectsCountCase.projectsCountCanceled:
      json["projectsCountCanceled"] ?? 0,
      ProjectsCountCase.projectsCountProgress:
      json["projectsCountProgress"] ?? 0,
    };

    for (var element in stars.values) {
      numberStars += element;
    }

    return ClientModel(
        addressCrypto: json["addressCrypto"],
        name:
        (json['lastName'] ?? json["name"]) + " " + (json['firstName'] ?? ""),
        uidFirebase: json['uidFirebase'],
        phoneNumber: json['phoneNumber'],
        sexe: json['sexe'],
        birthDate: DateTime.parse(json['birthDate']),
        profilePicture: json['profilePicture'] ?? "",
        stars: stars,
        projectsNumber: projectsNumber,
        starsNumber: numberStars,
        rating: (json["rating"] ?? 0).toString() ,
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

enum ProjectsCountCase {
  projectsCount,
  projectsCountFinished,
  projectsCountProgress,
  projectsCountCanceled
}
