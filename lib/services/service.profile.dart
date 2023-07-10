import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khidma_artisan_flutter/models/model.available.dart';
import '../controllers/Local/controller.local.dart';
import '../data/serveur.data.dart';
import '../models/general.dart';
import '../models/model.user.dart';

class ProfileService {
  static Future<General<String>> updatePic(String path) async {
    try {
      Map<String, String> headers = {
        'x-access-token': LocalController.getToken()
      };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(updatePicProfile),
      );
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
        'files',
        path,
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return General(data: response.body);
      }
      return General(error: true, returnMessage: "went_wrong".tr, data: "");
    } catch (e) {
      return General(error: true, returnMessage: "went_wrong".tr, data: "");
    }
  }

  static Future<bool> updateAvailability(AvailableModel available) async {
    try {
      String url = urlUpdateAvailability;
      var res = await http.put(Uri.parse(url),
          headers: {
            "x-access-token": LocalController.getToken(),
            "Content-Type": "application/json"
          },
          body: jsonEncode(available.toMap()));
      print(res.statusCode);
      if (res.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  static Future<General<String>> updateUser(Map modifiedData) async {
    try {
      String url = urlUpdateUser;
      http.Response res = await http.put(Uri.parse(url),
          headers: {'x-access-token': LocalController.getToken()},
          body: modifiedData);
      if (res.statusCode == 200) {
        return General(data: res.body);
      }
      return General(error: true, returnMessage: "went_wrong".tr, data: "");
    } catch (e) {
      return General(error: true, returnMessage: "went_wrong".tr, data: "");
    }
  }

  static Future<General<String>> updateAddress(String address) async {
    print('=====');
    try {
      String url = urlAddAddress;
      http.Response res = await http.put(Uri.parse(url),
          headers: {
            'x-access-token': LocalController.getToken(),
            "Content-Type": "application/json"
          },
          body: jsonEncode({"addressCrypto": address}));
      print(res.statusCode);
      print('');
      if (res.statusCode == 200) {
      var user= UserModel.fromJson(jsonDecode(res.body)["data"]["User"]);
      print(user.addressCrypto==null);
        return General(data: res.body);
      }
      return General(error: true, returnMessage: "went_wrong".tr, data: "");
    } catch (e) {
      return General(error: true, returnMessage: "went_wrong".tr, data: "");
    }
  }
}
