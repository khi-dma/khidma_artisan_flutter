import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/Local/controller.theme.dart';

Widget dialogBoxDelete(VoidCallback function) {
  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      width: 70.w,
      decoration: BoxDecoration(
          color: ThemeController.backScaffoldGroundColor(),
          borderRadius: BorderRadius.circular(7.sp)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: Text(
              "are you sure ?",
              style: TextStyle(fontSize: 13.sp),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Material(
            color: Colors.transparent,
            child: Text(
              "once you deleted \nyou can't turn it back ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp, color: ThemeController.tertiaryColor()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () =>Get.back(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.green),
                  )),
              SizedBox(
                width: 4.w,
              ),
              TextButton(
                  onPressed: function ,
                  child: const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          )
        ],
      ),
    ),
  );
}
