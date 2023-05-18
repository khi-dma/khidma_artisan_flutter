class OfferModel {
  final int idOffer;
  final int idPost;
  final int idArtisan;
  final String uidChat;

 const OfferModel({
    required this.uidChat,
    required this.idOffer,
    required this.idPost,
    required this.idArtisan,
  });

  static const OfferModel notNull =
       OfferModel(uidChat: "", idOffer: -1, idPost: -1, idArtisan: -1);

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      idOffer:int.parse( json['idOffer'].toString()) ,
      idPost:int.parse (json['idPost'].toString()) ,
      idArtisan:int.parse (json['idArtisan'].toString()),
      uidChat: json["uidChat"] ,
    );
  }

  Map<String, dynamic> toJson() => {
        'idOffer': idOffer,
        'idPost': idPost,
        'idArtisan': idArtisan,
    'uidChat':uidChat,
      };

  @override
  String toString() {
    return 'OfferModel{idOffer: $idOffer, idPost: $idPost, idArtisan: $idArtisan, uidChat: $uidChat}';
  }
}
