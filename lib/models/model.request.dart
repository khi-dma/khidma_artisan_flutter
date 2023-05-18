class RequestModel {
  final int idRequest;
  final int idArtisan;
  final int idPost;
  final String description;
  final String uidChat;

  const RequestModel(
      {required this.idRequest,
      required this.idPost,
      required this.description,
      required this.uidChat,
      required this.idArtisan});

  static const RequestModel notNull = RequestModel(
      idRequest: 0, idPost: 0, description: "", uidChat: '', idArtisan: -1);

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
      idRequest: int.parse(json['idRequest'].toString()),
      idPost: int.parse(json['idPost'].toString()),
      description: json['description'],
      uidChat: json["uidChat"],
      idArtisan: int.parse(json["idArtisan"].toString()));

  Map<String, dynamic> toJson() => {
        'idPost': idPost.toString(),
        'description': description.toString(),
        "uidChat": uidChat,
        "idRequest": idRequest.toString(),
        "idArtisan": idArtisan.toString()
      };

  @override
  String toString() {
    return 'RequestModel{idRequest: $idRequest, idArtisan: $idArtisan, idPost: $idPost, description: $description, uidChat: $uidChat}';
  }
}
