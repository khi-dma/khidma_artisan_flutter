import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.client.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:khidma_artisan_flutter/models/model.request.dart';
import 'package:khidma_artisan_flutter/services/service.client.dart';

import '../Posts/controller.abstractClass.dart';
import '../Posts/controller.save.dart';

class ClientDetailController extends PostAbstractClassController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getClient();
    getPosts();
  }

  ClientModel client;
  var error=false.obs;
  var downloading = false.obs;
  var downloadingPosts = false.obs;

  ClientDetailController({required this.client});

  getClient()async{
    switchState();
    var res = await ClientService.getClient(client.phoneNumber.toString());
    error.value = res.error;
    if (error.isFalse) {
      client= res.data;
    }
    switchState();
  }


  switchState() {
    downloading.value = !downloading.value;
  }
  switchStatePosts() {
    downloadingPosts.value = !downloadingPosts.value;
  }


  getPosts()async{
    switchStatePosts();
    var res  = await ClientService.getClientPosts(client.phoneNumber.toString());
    error.value = res.error;
    posts.value=res.data;
    switchStatePosts();

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

  @override
  switchSave(int index) {
    posts[index].saved.value = !(posts[index].saved.value);
    if (posts[index].saved.value) {
      SaveController().addPost(posts[index]);
    } else {
      SaveController().removePost(posts[index].idPost);
    }
  }


}