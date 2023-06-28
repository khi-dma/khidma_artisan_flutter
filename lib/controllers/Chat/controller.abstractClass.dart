import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/snackBar.dart';
import 'package:khidma_artisan_flutter/services/service.project.dart';
import 'package:khidma_artisan_flutter/views/Project/ProgressProject/widget.progressProject.dart';
import 'package:khidma_artisan_flutter/views/Project/preProjet/widget.preProject.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../models/model.chat.dart';
import '../../views/Project/FinishedProject/widget.finishedProject.dart';

abstract class ChatAbstractController extends GetxController {
  final ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  late ChatModel selectedChat;

  RoundedLoadingButtonController bottomBtnController =
      RoundedLoadingButtonController();

  addMessage();

  updateRead();

  selectChat(ChatModel chat, int index);

  toDetailsProject() async {
    var res = await ProjectService.getProject(selectedChat.uidChat);
    print(res.data.state);
    if (res.error) {
      snackBarModel("Failed", "Something went wrong", true);
    } else {
      if (res.data.state == 0 || res.data.state == 1) {
        Get.to(() => PreProjectWidget(
              project: res.data,
              from: 0,
            ));
      } else if (res.data.state == 2) {
        Get.to(() => ProgressProjectWidget(
              project: res.data,
              from: 0,
            ));
      } else if (res.data.state == 3) {
        Get.to(() => FinishedProjectWidget(
              project: res.data,
              from: 0,
            ));
      }
    }
  }
}
