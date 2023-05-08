import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

divider(){
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2),width: 0.6.sp))),
      );
}