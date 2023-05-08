import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/LocalController/controller.theme.dart';

Widget dialogBoxCheckDiploma() {
  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      width: 70.w,
      decoration: BoxDecoration(
          color: ThemeController.backScaffoldGroundColor(),
          borderRadius: BorderRadius.circular(7.sp)),
      child: Card(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Verification",
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Please wait until we check\n your diploma",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp,color: ThemeController.tertiaryColor()),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 100.sp,
              width: 100.sp,
              child:
                  Lottie.asset("assets/animations/102360-searching-file.json"),
            ),
            const Divider(),
            TextButton(
                onPressed: () =>Get.back(),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 15.sp),
                ))
          ],
        ),
      ),
    ),
  );
}
