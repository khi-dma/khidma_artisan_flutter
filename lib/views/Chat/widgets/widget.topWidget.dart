import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controllers/Chat/controller.abstractClass.dart';
import '../../../controllers/LocalController/controller.theme.dart';
import '../../../models/model.chat.dart';
import '../../../services/service.chat.dart';
import '../../Components/component.button.dart';
import '../../Project/preProjet/widget.preProject.dart';

Widget topWidgetChat(ChatModel chat, ChatAbstractController controller) {
  switch (chat.state) {
    case 0:
      return Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        color: ThemeController.backgroundColor(),
        width: 100.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buttonChat("CREATE PROJECT", () => ChatService.changeState(chat, 5))
          ],
        ),
      );
    case 5:
      return Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        color: ThemeController.backgroundColor(),
        width: 100.w,
        child: Column(
          children: [
            Text("Wait for " + chat.nameClient + " to accept"),
            SizedBox(
              height: 2.h,
            ),
            buttonChat("CANCEL", () => ChatService.changeState(chat, 0))
          ],
        ),
      );
    case 4:
      return Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        color: ThemeController.backgroundColor(),
        width: 100.w,
        child: Column(
          children: [
            Text(chat.nameClient + " wait for response"),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Expanded(
                    child: buttonChat(
                        "REFUSE", () => ChatService.changeState(chat, 0))),
                SizedBox(width: 3.w),
                Expanded(
                    child: buttonChat(
                        "REFUSE", () => ChatService.changeState(chat, 6))),
              ],
            ),
          ],
        ),
      );
    case 6:
      {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          color: ThemeController.backgroundColor(),
          width: 100.w,
          child: Column(
            children: [
              //Text(chat.nameArtisan + " wait for response"),
              SizedBox(
                height: 2.h,
              ),
              buttonChat(
                  "SEE PROJECT DETAILS",
                  () => Get.to(() => PreProjectWidget(
                      project: ProjectModel.notNull..id=chat.uidChat,
                      )))
            ],
          ),
        );
      }
    default:
      return const SizedBox();
  }
}
