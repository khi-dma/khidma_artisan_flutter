import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.local.dart';
import 'package:khidma_artisan_flutter/controllers/PostsControllers/controller.save.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:khidma_artisan_flutter/models/model.request.dart';
import 'package:khidma_artisan_flutter/services/service.post.dart';
import '../../models/model.offer.dart';
import 'controller.abstractClass.dart';

class PostController extends PostAbstractClassController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(onScroll);
    getPosts();
  }

  var haveNext = false;
  var error = false.obs;
  int page = 0;

  void getPosts() async {
    switchState();
    var res = await PostService.getPosts(page, search);
    error.value = res.error;
    if (!res.error) {
      if (page == 0) {
        posts.value = [];
      }
      preTreatment(res.data);
      posts.addAll(res.data);
      haveNext = res.haveNext;
    }

    switchState();
    switchFetchingState(res.error);
  }

  preTreatment(List<PostModel> posts) {
    final controller = SaveController();
    for (PostModel post in posts) {
      for (OfferModel offer in post.offers) {
        if (offer.idArtisan.toString() ==
            LocalController.getProfile().phoneNumber) {
          post.offered = true;
          post.offer = offer;
          break;
        }
      }
      for (RequestModel request in post.requests) {
        if (request.idArtisan.toString() ==
            LocalController.getProfile().phoneNumber) {
          post.requested.value = true;
          post.request = request;
          break;
        }
      }
      post.saved.value = controller.isSaved(post.idPost);
    }
  }

  ///// search
  String search = "";
  TextEditingController searchController = TextEditingController();

  submit(String? value) {
    //if ((searchController.text.isNotEmpty && searchController.text != search) ||
    //   (searchController.text.isEmpty && search.isNotEmpty)) {
    search = searchController.text;
    page = 0;
    getPosts();
    //}
  }


  clear(){
    search = "";
    searchController.clear();
    page = 0;
    getPosts();
  }

  /////// scroll
  final ScrollController scrollController = ScrollController();

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (haveNext) {
        ++page;
        getPosts();
      }
    }
  }

  //// UI STATE
  var downloading = false.obs;
  var downloadingPagination = false.obs;

  @override
  switchSave(int index) {
    posts[index].saved.value = !(posts[index].saved.value);
    if (posts[index].saved.value) {
      SaveController().addPost(posts[index]);
    } else {
      SaveController().removePost(posts[index].idPost);
    }
  }

  switchState() {
    if (page == 0) {
      if (first) {
        downloading.value = !downloading.value;
      }
    } else {
      downloadingPagination.value = !downloadingPagination.value;
    }
  }

  bool first = true;

  switchFetchingState(bool switchState) {
    if (first && !switchState) {
      first = !first;
    }
  }

  @override
  void function(RequestModel request) {
    currentPost.requested.value = true;
    currentPost.request=request;
    ++currentPost.requestsNumber;
    if (currentPost.saved.isTrue) {
      SaveController().removePost(currentPost.idPost);
      SaveController().addPost(currentPost);
    }
  }


}
