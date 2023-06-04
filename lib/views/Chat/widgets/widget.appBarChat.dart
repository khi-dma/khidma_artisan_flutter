import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constWidgets/cashedNetwork.dart';
import '../../../models/model.chat.dart';

AppBar appBarChat(ChatModel chat){
  return  AppBar(
    centerTitle: false,
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