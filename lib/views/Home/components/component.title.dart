import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/font.data.dart';
import '../../../data/pallete.data.dart';


Widget titleSeeAll(String title,Widget screen){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 14.sp, fontWeight: medium),
      ),
      InkWell(
        onTap: ()=>Get.to(()=>screen),
        child: Text(
          "See all",
          style: TextStyle(
              fontSize: 12.sp, fontWeight: medium, color: kGreyTextColor),
        ),
      ),
    ],
  );
}