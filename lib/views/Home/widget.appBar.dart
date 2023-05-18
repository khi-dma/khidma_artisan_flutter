import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../data/font.data.dart';
import '../Chat/widget.chat.dart';
import 'components/component.iconContainer.dart';

Widget appBarHome() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Khidma",
        style: TextStyle(fontSize: 20.sp, fontWeight: semiBold),
      ),
      Row(
        children: [
          iconContainerModel("notification",const ChatWidget()),
          SizedBox(
            width: 4.w,
          ),
          iconContainerModel("message",const ChatWidget()),
        ],
      )
    ],
  );
}
