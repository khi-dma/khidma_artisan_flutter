class RequestModel {
  int idRequest;
  int idPost;
  String description;

  RequestModel({
    required this.idRequest,
    required this.idPost,
    required this.description,
  });

  static RequestModel notNull =
      RequestModel(idRequest: 0, idPost: 0, description: "");

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        idRequest: int.parse(json['idRequest'].toString() ),
        idPost: int.parse(json['idPost'].toString()),
        description: json['description'] ,
      );

  Map<String, dynamic> toJson() => {
        'idPost': idPost.toString(),
        'description': description.toString(),
      };
}
