import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khidma_artisan_flutter/models/general.dart';
import 'package:khidma_artisan_flutter/models/model.document.dart';
import '../controllers/Local/controller.local.dart';
import '../data/serveur.data.dart';

class DiplomaService {
  static Future<General<List<DocumentModel>>> getDiploma() async {
    List<DocumentModel> diplomas = [];
    try {
      String url = urlGetDiploma;
      var res = await http.get(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()});

      if (res.statusCode == 200) {
        diplomas = jsonDecode(res.body)["data"]
            .map<DocumentModel>((data) => DocumentModel.fromJson(data))
            .toList();
        return General(data: diplomas);
      }
      return General(data: [], error: true);
    } catch (e) {
      return General(data: [], error: true);
    }
  }

  static Future<General<DocumentModel>> addPreviousWork(String path) async {
    DocumentModel document = DocumentModel.notNull;
    try {
      Map<String, String> headers = {
        'x-access-token': LocalController.getToken()
      };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(urlAddDiploma),
      );
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
        'files',
        path,
      ));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var dataJson = jsonDecode(response.body);
        document = DocumentModel.fromJson(
            dataJson["data"] as Map<String, dynamic>);
        return General(data: document);
      }
      return General( error: true, returnMessage: "went_wrong", data: document);
    } catch (e) {
      return General(
          error: true, returnMessage: "went_wrong", data: document);
    }
  }

  static Future<bool> deleteDiploma(int id) async {
    try {
      String url = urlGetDiploma+"/"+id.toString();
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



}
