import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khidma_artisan_flutter/models/general.dart';

import '../controllers/Local/controller.local.dart';
import '../data/serveur.data.dart';
import '../models/model.user.dart';

class AuthService {
  static Future<General<String>> verifyCode(String phoneNumber, String code,
      String verificationId, String notificationToken) async {
    login()async {
      PhoneAuthCredential credential =  PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);
      var user = await FirebaseAuth.instance.signInWithCredential(credential);
      LocalController.setUid(user.user!.uid);
    }

    try {
      http.Response response = await http.post(Uri.parse(urlLogin), body: {
        "phoneNumber": phoneNumber,
        "notificationToken": notificationToken,
        "code": code,
        "verificationId": verificationId
      });
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 401 && jsonData["success"] == false) {
        return General(
            error: true,
            data: "code is not correct",
            returnMessage: "code is not correct");
      }
      if (response.statusCode == 404 && jsonData["success"] == true) {
        await login();
        return General(
            data: response.body,
            exist: false,
            token: jsonData["data"]["token"]);
      }
      if (response.statusCode == 200) {
        await login();
        return General(
            data: response.body,
            exist: true,
            token: jsonData["data"]["token"],
            state: jsonData["data"]["state"]);
      }
      return General(error: true, data: "");
    } catch (e) {
      return General(error: true, data: "");
    }
  }

  static Future<General<String>> signUp(UserModel user, String token) async {
    try {
      http.Response res = await http.post(Uri.parse(urlSignUp),
          headers: {'x-access-token': token}, body: user.toJson());
      var jsonData = jsonDecode(res.body);
      if (res.statusCode == 401) {
        return General(error: true, data: "", returnMessage: "went_wrong".tr);
      }
      if (res.statusCode == 200) {
        return General(
            data: res.body, token: jsonData["data"]["token"]);
      }
      return General(error: true, data: "", returnMessage: "went_wrong".tr);
    } catch (e) {
      return General(error: true, data: "", returnMessage: "went_wrong".tr);
    }
  }

  static Future<General<String>> uploadFiles(
      String filePath1, String filePath2) async {
    try {
      Map<String, String> headers = {
        'x-access-token': LocalController.getToken()
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(urlUploadIdentity),
      );
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
        'files',
        filePath1,
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'files',
        filePath2,
      ));
      var res = await request.send();
      if (res.statusCode == 200) {
        return General( data: "");
      }
      return General(error: true, data: "", returnMessage: "went_wrong".tr);
    } catch (e) {
      return General(error: true, data: "", returnMessage: "went_wrong".tr);
    }
  }

  static Future<General<String>>  logOut()async{
    try{
      LocalController.setState(-1);
      return General( data: "");
    }catch(e){
      return General(error: true, data: "", returnMessage: "went_wrong".tr);
    }
  }

  static Future<General<String>> me()async {
    try{
      http.Response res = await http.get(Uri.parse(urlMe),
          headers: {'x-access-token': LocalController.getToken()});
      var jsonData = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return General(
            data: res.body,
            exist: true,
            state: jsonData["data"]["state"]);
      }
      return General( data: "",error: true);
    }catch(e){
      print(e);
      return General(error: true, data: "", returnMessage: "went_wrong".tr);
    }
  }


}
