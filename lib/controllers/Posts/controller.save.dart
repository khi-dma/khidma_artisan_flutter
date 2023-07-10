import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khidma_artisan_flutter/controllers/Posts/controller.post.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';

import '../../models/model.client.dart';
import '../../models/model.offer.dart';
import '../../models/model.request.dart';
import 'controller.abstractClass.dart';

class SaveController extends PostAbstractClassController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    read();
  }

  final box = GetStorage();

  addPost(PostModel post) {
    read();
    posts.add(post);
    write();
  }

  removePost(int idPost) {
    read();
    posts.removeWhere((post) => post.idPost == idPost);
    write();
  }

  read() {
    List<dynamic> postMaps = box.read("posts") ?? [];
    posts.value = postMaps.map((postMap) {
      bool requested = postMap['requested'];
      return PostModel(
        idPost: postMap['idPost'],
        title: postMap['title'],
        description: postMap['description'],
        city: postMap['city'],
        municipal: postMap['municipal'],
        idService: postMap['idService'],
        idClient: postMap['idClient'],
        date: postMap['date'],
        requestsNumber: postMap['requestsNumber'],
        urlPic: postMap['urlPic'],
        pathPic: postMap['pathPic'],
        newRequests: postMap['newRequests'],
        userClient: ClientModel.fromJson(postMap['userClient']),
        saved: RxBool(postMap['saved']),
        requested: requested.obs,
        offered: postMap['offered'],
        offer: OfferModel.fromJson(postMap['offer']),
        requests: List<RequestModel>.from(postMap['requests']
            .map((request) => RequestModel.fromJson(request))),
        offers: List<OfferModel>.from(
            postMap['offers'].map((offer) => OfferModel.fromJson(offer))),
        request: RequestModel.fromJson(postMap['request']),
        address: postMap["address"] == null
            ? const LatLng(0, 0)
            : LatLng(postMap["address"]["coordinates"][0],
                postMap["address"]["coordinates"][1]),
      );
    }).toList();
  }

  write() {
    List<Map<String, dynamic>> postMaps = posts
        .map((post) => {
              'idPost': post.idPost,
              'title': post.title,
              'description': post.description,
              'city': post.city,
              'municipal': post.municipal,
              'idService': post.idService,
              'idClient': post.idClient,
              'date': post.date,
              'requestsNumber': post.requestsNumber,
              'urlPic': post.urlPic,
              'pathPic': post.pathPic,
              'newRequests': post.newRequests,
              'userClient': post.userClient.toJson(),
              'saved': post.saved.value,
              'requested': post.requested.value,
              'offered': post.offered,
              'offer': post.offer.toJson(),
              'requests':
                  post.requests.map((request) => request.toJson()).toList(),
              'offers': post.offers.map((offer) => offer.toJson()).toList(),
              'request': post.request.toJson(),
            })
        .toList();
    box.write("posts", postMaps);
  }

  bool isSaved(int idPost) {
    read();
    return posts.where((post) => post.idPost == idPost).isNotEmpty;
  }

  @override
  switchSave(int index) {
    posts[index].saved.value = !(posts[index].saved.value);
    if (posts[index].saved.isFalse) {
      final controller = Get.find<PostController>();
      var indexPost = controller.posts
          .indexWhere((post) => post.idPost == posts[index].idPost);
      if (indexPost != -1) {
        controller.posts[indexPost].saved.value = false;
      }
    }
  }

  @override
  function(RequestModel request) {
    final controller = Get.find<PostController>();
    currentPost.requested.value = true;
    write();
    controller.getPosts();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    posts.removeWhere((post) => post.saved.isFalse);
    write();
  }
}
