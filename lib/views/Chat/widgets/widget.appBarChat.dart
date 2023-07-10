import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/views/Chat/widgets/widget.actionsChat.dart';
import 'package:sizer/sizer.dart';

import '../../../constWidgets/cashedNetwork.dart';
import '../../../models/model.chat.dart';

AppBar appBarChat(ChatModel chat){
  return  AppBar(
    centerTitle: false,
    actions: [
      Visibility(
          visible: chat.state != 2 && chat.state != 3 && chat.state != 7 && chat.state != 8,
          child: actionChat(chat))
    ],
    leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_rounded,
          size: 20.sp,
        )),
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 30.sp,
          width: 30.sp,
          child: ClipOval(
            child: cachedNetworkModel(chat.picArtisan),
          ),
        ),
        SizedBox(width: 3.w,),
        Expanded(
          child: Text(
            chat.titleChat,
            style: TextStyle(fontSize: 13.sp),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}