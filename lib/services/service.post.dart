import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khidma_artisan_flutter/models/general.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';

import '../controllers/LocalController/controller.local.dart';
import '../data/serveur.data.dart';
import '../models/model.request.dart';

class PostService {
  static Future<General<List<PostModel>>> getPosts(int page) async {
    String service = LocalController.getProfile().service.id.toString();
    String url = utlGetPosts + "service=$service&page=$page&size=10";
    try {
      var res = await http.get(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()});
      if (res.statusCode == 200) {
        List requests = [];
        List<PostModel> posts = [];

        var jsonData = jsonDecode(res.body);
        requests = jsonData["requests"];
        for (var item in jsonData["data"]) {
          PostModel post = PostModel.fromJson(item);
          for (var request in requests) {
            if (request as int == post.idPost) {
              post.requested = true;
              break;
            }
          }
          posts.add(post);
        }
        return General(data: posts, haveNext: !jsonData["lastPage"]);
      }
      return General(
          data: [], error: true, returnMessage: "Something went wrong");
    } catch (e) {
      return General(
          data: [], error: true, returnMessage: "Something went wrong");
    }
  }

  static Future<General<RequestModel>> request(RequestModel request) async {
    try {
      String url = urlAddRequest;
      var res = await http.post(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()},
          body: request.toJson());
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        RequestModel request = RequestModel.fromJson(jsonData["data"]);
        return General(
            data: request, error: false, returnMessage: "Something went wrong");
      }
      return General(
          data: RequestModel.notNull,
          error: true,
          returnMessage: "Something went wrong");
    } catch (e) {
      return General(
          data: RequestModel.notNull,
          error: true,
          returnMessage: "Something went wrong");
    }
  }
}
