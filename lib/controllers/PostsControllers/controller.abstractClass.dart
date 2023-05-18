import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.request.dart';

import '../../constWidgets/snackBar.dart';
import '../../data/const.data.dart';
import '../../models/model.chat.dart';
import '../../models/model.post.dart';
import '../../views/Chat/widget.messages.dart';
import '../../views/Posts/widget.request.dart';
import '../Chat/controller.message.dart';

abstract class PostAbstractClassController extends GetxController {
  late int currentPostRequestIndex;
  late PostModel currentPostRequest;

  RxList<PostModel> posts = <PostModel>[].obs;

  switchSave(int index);

  void function(RequestModel request);

  toRequest(int index) {
    if (posts[index].offered) {
      snackBarButton("Offer already sent", "Chat", () {
        Get.back();
        Get.to(() => MessageWidget(
              controller: Get.put(MessageController(
                  selectedChat: ChatModel.notNull
                    ..uidChat = posts[index].offer.uidChat)),
            ));
      }, Colors.orange);
    } else if (posts[index].requested.value) {
      snackBarButton("already requested", "Chat", () {
        Get.back();
        Get.to(() => MessageWidget(
              controller: Get.put(MessageController(
                  selectedChat: ChatModel.notNull
                    ..uidChat = posts[index].request.uidChat)),
            ));
      }, Colors.orange);
    } else {
      currentPostRequestIndex = index;
      currentPostRequest = posts[index];
      Get.bottomSheet(
          RequestWidget(
            post: currentPostRequest,
            function: function,
          ),
          isScrollControlled: true);
    }
  }
}
