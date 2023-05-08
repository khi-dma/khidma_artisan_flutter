import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/LocalController/controller.theme.dart';

Widget iconContainerModel(String icon, Widget screen) {
  return InkWell(
    onTap: () => Get.to(() => screen),
    child: Container(
      padding: EdgeInsets.all(13.sp),
      height: 42.sp,
      width: 42.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.sp),
        color: ThemeController.backgroundColor(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 9,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: SvgPicture.asset(
        "assets/icons/$icon.svg",
        color:  ThemeController.oppositeColor()
           ,
      ),
    ),
  );
}
