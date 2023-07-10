import 'package:khidma_artisan_flutter/controllers/Local/controller.local.dart';
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
  bool late;
  bool asSteps;
  StepModel currentStep;
  bool commentClient;
  bool commentArtisan;

  ProjectModel(
      {required this.commentClient,
      required this.commentArtisan,
      required this.currentStep,
      required this.asSteps,
      required this.late,
      required this.state,
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
      state: -1,
      late: false,
      asSteps: false,
      currentStep: StepModel.notNull,
      commentClient: false,
      commentArtisan: false);

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    List<StepModel> steps = json["Steps"] == null
        ? []
        : json["Steps"]
            .map<StepModel>((json) => StepModel.fromJson(json))
            .toList();

    sortByEndDate(steps);
    StepModel currentStep = StepModel.notNull;
    for (var step in steps) {
      if (!(step.checked)) {
        currentStep = step;
        break;
      }
    }
    print(json["commentClient"]);
    print(json["commentArtisan"]);
    return ProjectModel(
        checked: json["checked"] ?? false,
        steps: steps,
        price: json["price"] ?? 1000,
        client: ClientModel.fromJson(json["UserClient"]),
        post: PostModel.fromJson(json["Post"]),
        startDate: DateTime.parse(json["startDate"] ??
            DateTime.now().add(const Duration(hours: 2)).toString()),
        endDate: DateTime.parse(json["endDate"] ??
            DateTime.now().add(const Duration(days: 2)).toString()),
        artisan: LocalController.getProfile(),
        id: json["idProject"],
        title: json["title"] ?? "",
        state: json["state"],
        late: json["late"],
        asSteps: steps.isNotEmpty,
        currentStep: currentStep,
        commentClient: json["commentClient"]!=0,
        commentArtisan: json["commentArtisan"]!=0);
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
          sameSteps(other) &&
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

  bool sameSteps(ProjectModel other) {
    if (steps.length != other.steps.length) return false;
    for (var i = 0; i < other.steps.length; i++) {
      if (steps[i] != other.steps[i]) return false;
    }
    return true;
  }

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
        steps: steps.map<StepModel>((step) => step.clone()).toList(),
        price: price,
        client: client,
        post: post,
        startDate: startDate,
        endDate: endDate,
        title: title,
        state: state,
        late: late,
        asSteps: asSteps,
        currentStep: currentStep,
        commentClient: commentClient,
        commentArtisan: commentArtisan);
  }

  @override
  String toString() {
    return 'ProjectModel{state: $state}';
  }
}

void sortByEndDate(List<StepModel> list) {
  list.sort((a, b) => a.endDate.compareTo(b.endDate));
}
