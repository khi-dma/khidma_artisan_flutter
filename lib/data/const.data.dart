import '../models/model.request.dart';
import '../models/model.service.dart';

List genre = ["Homme", "Femme"];

List<ServiceModel> services = [
  ServiceModel(id: 6, name: "hairdresser", image: "hair-cutting"),
  ServiceModel(id: 5, name: "Baby sitter", image: "mother"),
  ServiceModel(id: 1, name: "Plumber", image: "Plumber"),
  ServiceModel(id: 2, name: "Electrician", image: "Electrician"),
  ServiceModel(id: 3, name: "Painting", image: "Painting"),
  ServiceModel(id: 4, name: "Gardener", image: "Gardener"),
];

typedef RequestCallback =void Function(RequestModel request);

typedef StringParameterFunction = void Function(String parameter);