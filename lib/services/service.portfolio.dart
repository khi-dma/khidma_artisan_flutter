import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khidma_artisan_flutter/models/general.dart';
import 'package:khidma_artisan_flutter/models/model.portFolio.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import '../controllers/LocalController/controller.local.dart';
import '../data/serveur.data.dart';
import '../models/model.request.dart';

class PortfolioService {
  static Future<General<PortfolioModel>> getPortfolio() async {
    PortfolioModel portFolio = PortfolioModel.notNull;
    try {
      String url = urlGetPortFolio;
      var res = await http.get(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()});
      if (res.statusCode == 200) {
        portFolio = PortfolioModel.fromJson(
            jsonDecode(res.body)["data"] as Map<String, dynamic>);
        return General(data: portFolio);
      }
      return General(data: portFolio, error: true);
    } catch (e) {
      return General(data: portFolio, error: true);
    }
  }

  static Future<General<PreviousWorkModel>> addPreviousWork(
      PreviousWorkModel previousWork) async {
    try {
      Map<String, String> headers = {
        'x-access-token': LocalController.getToken()
      };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(urlUploadPicPortFolio),
      );
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
        'files',
        previousWork.pathPic,
      ));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var dataJson = jsonDecode(response.body);
        previousWork.pathPic = dataJson["data"]["path"];
        previousWork.urlPic = dataJson["data"]["url"];
        http.Response res = await http.post(Uri.parse(urlAddPortFolio),
            headers: {'x-access-token': LocalController.getToken()},
            body: previousWork.toJson());
        if (res.statusCode == 200) {
          PreviousWorkModel previousWork = PreviousWorkModel.notNull;
          var jsonData = jsonDecode(res.body);
          previousWork = PreviousWorkModel.fromJson(
              jsonData["data"] as Map<String, dynamic>);

          return General(data: previousWork);
        } else {
          return General(
              error: true, returnMessage: "went_wrong".tr, data: previousWork);
        }
      }
      return General(
          error: true, returnMessage: "went_wrong".tr, data: previousWork);
    } catch (e) {
      return General(
          error: true, returnMessage: "went_wrong".tr, data: previousWork);
    }
  }

  static Future<bool> editPreviousWork(Map modifiedData, int id) async {
    try {
      String url = urlDeletePortFolio + "/" + id.toString();
      var res = await http.put(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()},
          body: modifiedData);
      if (res.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  static Future<bool> deletePreviousWork(int idPreviousWork) async {
    try {
      String url = urlDeletePortFolio + "/" + idPreviousWork.toString();
      var res = await http.delete(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()});
      if (res.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  static Future<bool> updateDescription(String description) async {
    try {
      String url = urlUpdateDescription;
      var res = await http.put(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()},
          body: {"description": description});
      if (res.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }
}
