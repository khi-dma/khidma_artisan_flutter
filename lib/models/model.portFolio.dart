import 'package:get/get.dart';

class PortfolioModel {
  String description;
  RxList<PreviousWorkModel> previousWork;

  static PortfolioModel notNull =
      PortfolioModel(description: "", previousWork: <PreviousWorkModel>[].obs);

  PortfolioModel({required this.description, required this.previousWork});

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
        previousWork: RxList<PreviousWorkModel>.from(
          json["portfolio"].map<PreviousWorkModel>((json) => PreviousWorkModel.fromJson(json)).toList(),
        ),
        description: json["description"]);
  }

  @override
  String toString() {
    return 'PortFolioModel{description: $description, previousWork: $previousWork, notNull: $notNull}';
  }
}

class PreviousWorkModel {
  int id;
  String title;
  String pathPic;
  String urlPic;
  String description;

  PreviousWorkModel(
      {required this.id,
      required this.title,
      required this.pathPic,
      required this.urlPic,
      required this.description});

  factory PreviousWorkModel.fromJson(Map<String, dynamic> json) {
    return PreviousWorkModel(
        id: json["idPortfolio"],
        title: json["title"],
        pathPic: json["pathPic"],
        urlPic: json["urlPic"],
        description: json["description"]);
  }

  static PreviousWorkModel notNull = PreviousWorkModel(id: -1, title: "", pathPic: "", urlPic: "", description: "");

  toJson(){
    return {
      "title":title,
      "description":description,
      "urlPic":urlPic,
      "pathPic":pathPic
    };
  }

  @override
  String toString() {
    return 'PreviousWork{id: $id, title: $title, picPath: $pathPic, picUrl: $urlPic, description: $description}';
  }
}
