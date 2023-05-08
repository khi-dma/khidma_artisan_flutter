import 'package:flutter/material.dart';
import '../../data/pallete.data.dart';
import 'package:sizer/sizer.dart';


Widget circularProgressModel( ) => Center(
  child:   SizedBox(
      height: 7.h,
      width: 7.h,
      child: const Center(
        child: CircularProgressIndicator(
            color: kPrimaryColor),
      )),
);

Widget paginationModel() => Container(
    margin: EdgeInsets.symmetric(vertical: 3.h),
    child: Text(
      "more",
      style: TextStyle(
          color: kPrimaryColor, fontSize: 13.sp, fontWeight: FontWeight.w600),
    ));