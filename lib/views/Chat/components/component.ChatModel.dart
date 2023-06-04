import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../constWidgets/cashedNetwork.dart';
import '../../../controllers/Chat/controller.Chat.dart';
import '../../../controllers/Chat/controller.abstractClass.dart';
import '../../../controllers/LocalController/controller.theme.dart';
import '../../../data/font.data.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

import '../../../models/model.chat.dart';

Widget chatWidgetModel(ChatModel chat,int index,ChatAbstractController controller) {
  final controller = Get.find<ChatController>();

  bool _isUrl = Uri.parse(chat.lastMessage).isAbsolute;
  bool readArtisan = chat.readArtisan ;
  return GetBuilder(
    init: controller,
    id: "chat",
    builder: (context) {
      final difference = timeago.format(chat.lastMessageDate,
          locale: 'fr');
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.sp),
        ),
        color:readArtisan ? ThemeController.backgroundColor():ThemeController.tertiaryColor(),//chat.readClient ? kGreyBackColor:Colors.black54.withOpacity(0.4),
        child: ListTile(
          onTap: ()=>controller.selectChat(chat,index),
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
          subtitle: Row(
            children: [
              Flexible(
                child: Text(
                   _isUrl ? "image":chat.lastMessage ,
                  style: TextStyle(fontSize: 9.sp, color: readArtisan ?Colors.grey:Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "  - " + difference,
                style: TextStyle(fontSize: 9.sp, color: readArtisan ?Colors.grey:Colors.white),
              ),
            ],
          ),

        ),
      );
    }
  );
}
