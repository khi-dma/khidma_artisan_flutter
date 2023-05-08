class ChatModel {
  String nameClient;
  String nameArtisan;
  int phoneNumberClient;
  int phoneNumberArtisan;
  String picArtisan;
  String picClient;
  String titleChat;
  String uidArtisan;
  String uidClient;
  String uidChat;
  String lastMessage;
  DateTime lastMessageDate;
  int lastSender;
  bool readClient;
  bool readArtisan;

  ChatModel({
    required this.readArtisan,
    required this.readClient,
    required this.lastSender,
    required this.nameClient,
    required this.nameArtisan,
    required this.phoneNumberClient,
    required this.phoneNumberArtisan,
    required this.picArtisan,
    required this.picClient,
    required this.titleChat,
    required this.uidArtisan,
    required this.uidClient,
    required this.uidChat,
    required this.lastMessage,
    required this.lastMessageDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'readClient': readClient,
      'readArtisan': readArtisan,
      'lastSender': lastSender,
      'nameClient': nameClient,
      'nameArtisan': nameArtisan,
      'phoneNumberClient': phoneNumberClient,
      'phoneNumberArtisan': phoneNumberArtisan,
      'picArtisan': picArtisan,
      'picClient': picClient,
      'titleChat': titleChat,
      'uidArtisan': uidArtisan,
      'uidClient': uidClient,
      'uidChat': uidChat,
      'lastMessage': lastMessage,
      'lastMessageDate': lastMessageDate,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      readArtisan: json["readArtisan"],
      lastSender: json["lastSender"],
      nameClient: json['nameClient'],
      nameArtisan: json['nameArtisan'],
      phoneNumberClient: json['phoneNumberClient'],
      phoneNumberArtisan: json['phoneNumberArtisan'],
      picArtisan: json['picArtisan'],
      picClient: json['picClient'],
      titleChat: json['titleChat'],
      uidArtisan: json['uidArtisan'],
      uidClient: json['uidClient'],
      uidChat: json['uidChat'],
      lastMessage: json['lastMessage'],
      lastMessageDate: json['lastMessageDate'].toDate(),
      readClient: json["readClient"],
    );
  }
}
