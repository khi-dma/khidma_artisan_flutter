import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:sizer/sizer.dart';

Widget rowModel(String title, String content,VoidCallback? function) {
  return InkWell(
    onTap: function,
    child: Padding(
      padding:  EdgeInsets.symmetric(vertical: 1.3.h,horizontal: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 11.sp,color: ThemeController.secondaryColor()),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 12.sp,color: ThemeController.oppositeColor().withOpacity(function==null?0.6:1)),
          ),
        ],
      ),
    ),
  );
}
