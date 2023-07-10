import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khidma_artisan_flutter/models/general.dart';
import 'package:khidma_artisan_flutter/models/model.client.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/models/model.user.dart';

import '../controllers/Local/controller.local.dart';
import '../data/serveur.data.dart';

class ClientService {
  static Future<General<ClientModel>> getClient(String id) async {
    String url = urlGetClient + id;
    try {
      Map<String, String> headers = {
        'x-access-token': LocalController.getToken()
      };
      http.Response res = await http.get(Uri.parse(url), headers: headers);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        return General(data: ClientModel.fromJson(jsonData["data"]));
      }
      return General(
          error: true,
          returnMessage: "went_wrong".tr,
          data: ClientModel.notNull);
    } catch (e) {
      return General(data: ClientModel.notNull);
    }
  }

  static Future<General<List<PostModel>>> getClientPosts(String id) async {
    String url = urlGetClientPosts + id;
    try {
      Map<String, String> headers = {
        'x-access-token': LocalController.getToken()
      };
      http.Response res = await http.get(Uri.parse(url), headers: headers);
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        return General(
            data: jsonData["data"]
                .map<PostModel>((json) => PostModel.fromJson(json))
                .toList());
      }
      return General(error: true, returnMessage: "went_wrong".tr, data: []);
    } catch (e) {
      return General(data: []);
    }
  }
}
