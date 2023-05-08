import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../data/font.data.dart';

void snackBarModel(String title,String message, bool isError) {
  Get.snackbar(
    title,
    message,
    titleText: Text(title,style: TextStyle(fontSize: 12.sp,color: Colors.white,fontWeight: semiBold),),
    messageText:  Text(message,style: TextStyle(fontSize: 12.sp,color: Colors.white,fontWeight: regular),),
    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
    margin: EdgeInsets.all(10.sp),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    colorText: Colors.white,
    backgroundColor:  isError ? Colors.red : Colors.green,
    icon: Icon(isError ?Icons.warning  : Icons.done, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 5.sp,
  );
}

void snackBarModelTop(String title,String message, bool isError) {
  Get.snackbar(
    title,
    message,
    titleText: Text(title,style: TextStyle(fontSize: 12.sp,color: Colors.white,fontWeight: semiBold),),
    messageText:  Text(message,style: TextStyle(fontSize: 12.sp,color: Colors.white,fontWeight: regular),),
    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
    margin: EdgeInsets.all(15.sp),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    colorText: Colors.white,
    backgroundColor:  isError ? Colors.red : Colors.green,
    icon: Icon(isError ?Icons.warning  : Icons.done, color: Colors.white),
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 2),
  );
}