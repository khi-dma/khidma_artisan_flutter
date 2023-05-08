import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../data/font.data.dart';

Widget errorWidget() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 60.sp,
            width: 60.sp,
            child: Lottie.asset("assets/animations/95614-error-occurred.json")),
        SizedBox(
          height: 2.h,
        ),
        Text(
          "Something went wrong",
          style: TextStyle(fontSize: 13.sp, fontWeight: medium, color:ThemeController.oppositeColor()),
        ),
      ],
    ),
  );
}
