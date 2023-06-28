import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../data/font.data.dart';
import '../../data/pallete.data.dart';

RoundedLoadingButton animatedButton(String title, VoidCallback? function,
    RoundedLoadingButtonController btnController,
    [color = kPrimaryColor]) {
  return RoundedLoadingButton(
    resetAfterDuration: false,
    successColor: kGreenColor,
    height: 40.sp,
    width: 100.w,
    color: color,
    disabledColor: kPrimaryColor.withOpacity(0.6),
    elevation: 0,
    borderRadius: 10.sp,
    child: Text(title,
        style: TextStyle(
            color: Colors.white.withOpacity(function==null ? 0.4:1), fontWeight: semiBold, fontSize: 13.sp)),
    controller: btnController,
    onPressed: function,
  );
}

Widget buttonChat(String title, VoidCallback? function) {
  return InkWell(
    onTap: function,
    child: Container(
      height: 35.sp,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: Colors.grey,
      ),
      child: Center(
        child: Text(title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: semiBold,
                fontSize: 13.sp)),
      ),
    ),
  );
}

Widget button(String title, VoidCallback function, [color = kPrimaryColor]) {
  return TextButton(
    style: TextButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
        backgroundColor: color,
        fixedSize: Size.fromHeight(
          40.sp,
        )),
    onPressed: function,
    child: Center(
        child: Text(
      title,
      style:
          TextStyle(color: Colors.white, fontWeight: semiBold, fontSize: 13.sp),
    )),
  );
}

Widget animatedButtonSecondary(String title, VoidCallback? function,
    RoundedLoadingButtonController btnController,
    [color = kGreenColor]) {
  return RoundedLoadingButton(
    valueColor: kPrimaryColor,
    resetAfterDuration: false,
    successColor: kGreenColor,
    height: 40.sp,
    width: 100.w,
    color: const Color(0xff2f2f2f),
    disabledColor: const Color(0xff2f2f2f).withOpacity(0.3),
    elevation: 0,
    borderRadius: 10.sp,
    child: Text(title,
        style: TextStyle(
            color: kPrimaryColor.withOpacity(function==null ? 0.4:1), fontSize: 13.sp)),
    controller: btnController,
    onPressed: function,
  );
}
