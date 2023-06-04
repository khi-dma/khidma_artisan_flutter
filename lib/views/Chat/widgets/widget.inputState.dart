import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/Chat/controller.abstractClass.dart';
import '../../../controllers/LocalController/controller.theme.dart';
import '../../../models/model.chat.dart';
import '../../../services/service.chat.dart';
import '../../Components/component.button.dart';
import '../../Components/component.inputChat.dart';

Widget bottomWidgetChat(ChatModel chat, ChatAbstractController controller) {
  switch (chat.state) {
    case 3:
      return Column(
        children: [
          Divider(
            height: 0,
            color: ThemeController.oppositeColor(),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "You have blocked this chat",
            style: TextStyle(fontSize: 12.sp),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: animatedButton(
                "Unblock",
                () => ChatService.changeState(chat, chat.preState),
                controller.bottomBtnController),
          ),
        ],
      );
    case 2:
      return Column(
        children: [
          Divider(
            height: 0,
            color: ThemeController.oppositeColor(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Text(chat.nameClient + ' has blocked this chat'),
          )
        ],
      );
    case 1:
      return Column(
        children: [
          Divider(
            height: 0,
            color: ThemeController.oppositeColor(),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            chat.nameClient + " offer this post for you",
            style: TextStyle(fontSize: 12.sp),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Row(
              children: [
                Expanded(
                    child: animatedButton("BLOCK", () {},
                        controller.bottomBtnController, Colors.redAccent)),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                    child: animatedButton(
                        "ACCEPT", () {}, controller.bottomBtnController)),
              ],
            ),
          ),
        ],
      );
    case 7:
      return Column(
        children: [
          Divider(
            height: 0,
            color: ThemeController.oppositeColor(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: const Text("You have created project for this psot"),
          ),
        ],
      );
    default:
      {
        return Container(
          padding: EdgeInsets.all(5.sp),
          color: ThemeController.backScaffoldGroundColor(),
          child: InputChat(
              textEditingController: controller.messageController,
              function: controller.addMessage),
        );
      }
  }
}
