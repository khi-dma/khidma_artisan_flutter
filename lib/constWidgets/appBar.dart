// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

appBarModel(String title) => AppBar(
      leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 20.sp,
          )),
      title: Text(
        title,
        style: TextStyle(fontSize: 14.sp),
      ),
    );
