import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/snackBar.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:khidma_artisan_flutter/models/model.request.dart';
import 'package:khidma_artisan_flutter/services/service.post.dart';
import 'package:khidma_artisan_flutter/views/Posts/widget.request.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PostController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(onScroll);
  }

  var haveNext = false;
  var error = false.obs;
  RxList<PostModel> posts = <PostModel>[].obs;
  int currentPostRequest = 0;
  int page = 0;

  void getPosts() async {
    switchState();
    var res = await PostService.getPosts(page);
    if (res.error) {
      error.value = true;
    } else {
      error.value = false;
      if (page == 0) {
        posts.value = [];
      }
      posts.addAll(res.data);
      haveNext = res.haveNext;
    }
    switchState();
    switchFetchingState(res.error);
  }

  switchSave(int index) {
    posts[index].saved.value = !(posts[index].saved.value);
  }

  var downloading = false.obs;
  var downloadingPagination = false.obs;

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

  toRequest(int index) {
    currentPostRequest = index;
    requestController.clear();
    Get.to(() => const RequestWidget());
  }

  //////// request
  TextEditingController requestController = TextEditingController();
  StringValidationCallback requestValidate = ValidationBuilder()
      .minLength(200, 'too short')
      .maxLength(700, 'too long')
      .build();

  var numberCharDesc = "0/500".obs;

  changeRequest(String? p1) {
    numberCharDesc.value = requestController.text.length.toString() + "/500";
  }

  Color longDescription() {
    return requestController.text.length > 200 ||
            requestController.text.length < 700
        ? Colors.redAccent
        : Colors.green;
  }

  request() async {
    if (formKey.currentState!.validate()) {
      btnController.stop();
      var res = await PostService.request(RequestModel(
          idRequest: -1,
          idPost: posts[currentPostRequest].idPost,
          description: requestController.text));
      if(res.error){
        snackBarModel("failed", "Something went wrong", true);
      }else{
        Get.back();
        snackBarModel("Success", "Request sent", false);
      }
      btnController.stop();
    }else{
      btnController.stop();
    }
  }
}
