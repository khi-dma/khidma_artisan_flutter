class ServiceModel {
  int id;
  String name;
  String image;

  ServiceModel({required this.id, required this.name,required this.image});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image':image
  };
}