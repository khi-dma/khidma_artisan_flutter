class UserClient {
  String name;
  String uidFirebase;
  int phoneNumber;
  int sexe;
  DateTime birthDate;
  String profilePicture;
  DateTime createdAt;
  DateTime updatedAt;

  UserClient({
    required this.name,
    required this.uidFirebase,
    required this.phoneNumber,
    required this.sexe,
    required this.birthDate,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserClient.fromJson(Map<String, dynamic> json) {
    return UserClient(
      name: json['lastName']+" "+ json['firstName'],
      uidFirebase: json['uidFirebase'],
      phoneNumber: json['phoneNumber'],
      sexe: json['sexe'],
      birthDate: DateTime.parse(json['birthDate']),
      profilePicture: json['profilePicture']??"",
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );

  }

  @override
  String toString() {
    return 'UserClient{name: $name, uidFirebase: $uidFirebase, phoneNumber: $phoneNumber, sexe: $sexe, birthDate: $birthDate, profilePicture: $profilePicture, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}