import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khidma_artisan_flutter/models/general.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import '../controllers/Local/controller.local.dart';
import '../data/serveur.data.dart';
import '../models/model.request.dart';

class PostService {
  static Future<General<List<PostModel>>> getPosts(int page,String search) async {
    String service = LocalController.getProfile().service.id.toString();
    String city = LocalController.getProfile().city.toString();
    String municipal = LocalController.getProfile().municipal.toString();
    String url = utlGetPosts + "service=$service&page=$page&size=10&search=$search&city=$city&municipal=$municipal";
    try {
      var res = await http.get(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()});
      if (res.statusCode == 200) {
        List<PostModel> posts = [];
        var jsonData = jsonDecode(res.body);
        posts = jsonData["data"].map<PostModel>((item)=>PostModel.fromJson(item)).toList();
        return General(data: posts, haveNext: !jsonData["lastPage"]);
      }
      return General(
          data: [], error: true, returnMessage: "Something went wrong");
    } catch (e) {
      print(e);
      return General(
          data: [], error: true, returnMessage: "Something went wrong");
    }
  }

  static Future<General<RequestModel>> request(RequestModel request) async {
    try {
      String url = urlAddRequest+"/post/"+request.idPost.toString();
      var res = await http.post(Uri.parse(url),
          headers: {"x-access-token": LocalController.getToken()},
          body: request.toJson());
      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        print(jsonData["data"]);
        RequestModel request = RequestModel.fromJson(jsonData["data"]);
        return General(
            data: request, error: false, returnMessage: "Something went wrong");
      }
      return General(
          data: RequestModel.notNull,
          error: true,
          returnMessage: "Something went wrong");
    } catch (e) {
      print(e);
      return General(
          data: RequestModel.notNull,
          error: true,
          returnMessage: "Something went wrong");
    }
  }
}
