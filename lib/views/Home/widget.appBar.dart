import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/views/Posts/widget.posts.dart';
import 'package:sizer/sizer.dart';
import '../../data/font.data.dart';
import '../Chat/widget.chat.dart';
import 'components/component.iconContainer.dart';

Widget appBarHome() {
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 6.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Khidma",
          style: TextStyle(fontSize: 20.sp, fontWeight: semiBold),
        ),
        Row(
          children: [
            iconContainerModel("search", PostsWidget()),
            SizedBox(
              width: 4.w,
            ),
            iconContainerModel("message",const ChatWidget()),
          ],
        )
      ],
    ),
  );
}
