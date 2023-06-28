import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/profile/controller.diploma.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

Widget emptyDiplomaWidget() {
  final controller = Get.find<DiplomaController>();
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 200.sp,
            width: 200.sp,
            child: LottieBuilder.asset(
                "assets/animations/88009-diploma-certificate-animation-icon.json")),
        SizedBox(height: 6.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: button("Add diploma",controller.choosePic),
        )
      ],
    ),
  );
}
