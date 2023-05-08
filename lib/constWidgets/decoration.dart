import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

BoxDecoration defaultDecoration(double radius, Color color,bool shadow) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius.sp),
    color: color,
    boxShadow: !shadow ? null :[
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 9,
        offset: const Offset(0, 2), // changes position of shadow
      ),
    ],
  );
}
