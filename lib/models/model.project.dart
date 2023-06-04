import 'package:khidma_artisan_flutter/controllers/LocalController/controller.local.dart';
import 'package:khidma_artisan_flutter/models/model.client.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:khidma_artisan_flutter/models/model.step.dart';
import 'package:khidma_artisan_flutter/models/model.user.dart';

class ProjectModel {
  String id;
  List<StepModel> steps;
  int price;
  ClientModel client;
  UserModel artisan;
  PostModel post;
  DateTime startDate;
  DateTime endDate;
  bool checked;
  String title;
  int state;

  ProjectModel(
      {required this.state,
      required this.checked,
      required this.artisan,
      required this.id,
      required this.steps,
      required this.price,
      required this.client,
      required this.post,
      required this.startDate,
      required this.endDate,
      required this.title});

  static ProjectModel notNull = ProjectModel(
      id: "-1",
      steps: [],
      price: -1,
      client: ClientModel.notNull,
      post: PostModel.notNull,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      artisan: LocalController.getProfile(),
      checked: false,
      title: '',
      state: -1);

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
        checked: json["checked"] ?? false,
        steps: json["Steps"] == null
            ? []
            : json["Steps"]
                .map<StepModel>((json) => StepModel.fromJson(json))
                .toList(),
        price: json["price"] ?? 1000,
        client: ClientModel.fromJson(json["UserClient"]),
        post: PostModel.fromJson(json["Post"]),
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"])
            : DateTime.now(),
        endDate: json["endDate"] != null
            ? DateTime.parse(json["endDate"])
            : DateTime.now().add(const Duration(days: 2)),
        artisan: LocalController.getProfile(),
        id: json["idProject"],
        title: json["title"] ?? "",
        state: json["state"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps.map((e) => e.toJson()).toList(),
      'price': price,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'checked': checked,
      'title': title.toString()
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          steps == other.steps &&
          price == other.price &&
          client == other.client &&
          artisan == other.artisan &&
          post == other.post &&
          startDate.year == other.startDate.year &&
          startDate.day == other.startDate.day &&
          startDate.month == other.startDate.month &&
          startDate.hour == other.startDate.hour &&
          startDate.minute == other.startDate.minute &&
          endDate.year == other.endDate.year &&
          endDate.day == other.endDate.day &&
          endDate.month == other.endDate.month &&
          endDate.hour == other.endDate.hour &&
          endDate.minute == other.endDate.minute &&
          checked == other.checked &&
          title == other.title;

  @override
  int get hashCode =>
      id.hashCode ^
      steps.hashCode ^
      price.hashCode ^
      client.hashCode ^
      artisan.hashCode ^
      post.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      checked.hashCode ^
      title.hashCode;

  ProjectModel clone() {
    return ProjectModel(
        checked: checked,
        artisan: artisan,
        id: id,
        steps: steps,
        price: price,
        client: client,
        post: post,
        startDate: startDate,
        endDate: endDate,
        title: title, state: state);
  }

  @override
  String toString() {
    return 'ProjectModel{id: $id,  price: $price, client: $client, artisan: $artisan, post: $post, startDate: $startDate, endDate: $endDate, checked: $checked, title: $title, state: $state}';
  }
}
