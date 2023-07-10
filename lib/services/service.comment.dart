import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khidma_artisan_flutter/models/model.CommentClient.dart';

import '../controllers/Local/controller.local.dart';
import '../data/serveur.data.dart';
import '../models/general.dart';

class RatingService{

  static Future<General<List<CommentArtisanModel>>> getComments(String id , String stars)async {
    try {
      var res = await http.get(Uri.parse(urlComments+id+"/ratings/"+stars),
          headers: {"x-access-token": LocalController.getToken()});
      print(urlComments+id+"/ratings/"+stars);
      if (res.statusCode == 200) {
        var jsonData= jsonDecode(res.body);
        return General(
          data: jsonData["data"]
              .map<CommentArtisanModel>((json) => CommentArtisanModel.fromJson(json))
              .toList(),
        );
      }
      return General(
        data: [],
        error: true,
      );
    } catch (e) {
      return General(data: [],error: true);
    }
  }
}

