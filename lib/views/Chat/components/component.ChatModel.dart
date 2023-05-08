import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../constWidgets/cashedNetwork.dart';
import '../../../controllers/Chat/controller.Chat.dart';
import '../../../controllers/LocalController/controller.theme.dart';
import '../../../data/font.data.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

import '../../../models/model.chat.dart';

Widget chatWidgetModel(ChatModel chat) {
  final controller = Get.find<ChatController>();
  final difference = timeago.format(chat.lastMessageDate,
      locale: 'fr');
  return GetBuilder(
    init: controller,
    id: "chat",
    builder: (context) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.sp),
        ),
        color:chat.readClient ? ThemeController.backgroundColor():ThemeController.tertiaryColor(),//chat.readClient ? kGreyBackColor:Colors.black54.withOpacity(0.4),
        child: ListTile(
          onTap: ()=>controller.selectChat(chat),
          leading: SizedBox(
            height: 30.sp,
            width: 30.sp,
            child: ClipOval(
              child: cachedNetworkModel(chat.picArtisan),
            ),
          ),
          title: Text(
            chat.titleChat,
            style: TextStyle(fontSize: 11.4.sp, fontWeight: medium),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            chat.lastMessage + "  - " + difference,
            style: TextStyle(fontSize: 9.sp, color: chat.readClient ?Colors.grey:Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

        ),
      );
    }
  );
}
