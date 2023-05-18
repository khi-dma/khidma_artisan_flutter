import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../constWidgets/appBar.dart';
import '../../constWidgets/emptyList.dart';
import '../../constWidgets/errorWidget.dart';
import '../../constWidgets/progressIndicator.dart';
import '../../controllers/Chat/controller.Chat.dart';
import 'components/component.ChatModel.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("Chats"),
      body: Obx(
        () => controller.downloading.value
            ? circularProgressModel()
            : controller.error.value
                ? errorWidget()
                : controller.chats.isEmpty
                    ? emptyListWarning()
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        itemBuilder: (context, index) => chatWidgetModel(
                            controller.chats[index], index, controller),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 2.h),
                        itemCount: controller.chats.length,
                      ),
      ),
    ));
  }
}
