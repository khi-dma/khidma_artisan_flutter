import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khidma_artisan_flutter/models/general.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';

import '../controllers/LocalController/controller.local.dart';
import '../data/serveur.data.dart';

class ProjectService {
  static Future<General<List<ProjectModel>>> getProjects() async {
    try {
      String url = utlGetProjects;
      var res = await http.get(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()});
      if (res.statusCode == 200) {
        List<ProjectModel> projects = [];
        var jsonData = jsonDecode(res.body);
        projects = jsonData["data"]
            .map<ProjectModel>((json) => ProjectModel.fromJson(json))
            .toList();
        return General(
          data: projects,
        );
      }
      return General(
        data: [],
        error: true,
      );
    } catch (e) {
      return General(
        data: [],
        error: true,
      );
    }
  }

  static Future<General<ProjectModel>> getProject(String idProject) async {
    try {
      String url = utlGetProject + idProject;

      var res = await http.get(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()});
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        return General(data: ProjectModel.fromJson(jsonData["data"]));
      }
      return General(data: ProjectModel.notNull, error: true);
    } catch (e) {
      return General(
        data: ProjectModel.notNull,
        error: true,
      );
    }
  }

  static Future<bool> putProject(ProjectModel project) async {
    try {
      String url = utlPutProject + project.id;
      var res = await http.put(Uri.parse(url),
          headers: {
            "x-access-token": LocalController.getToken(),
            "Content-Type": "application/json"
          },
          body: json.encode(project.toJson()));
      if (res.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  static Future<bool> launchProject(ProjectModel project) async {
    try {
      String url = utlLaunchProject + project.id + "/launch";
      var res = await http.put(
        Uri.parse(url),
        headers: {
          "x-access-token": LocalController.getToken(),
        },
      );
      if (res.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }
}
