import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/authControllers/controller.signUp.dart';
import '../../data/constCities.data.dart';


showCities(BuildContext context) {
  final controller =
  Get.find<SignUpController>();
  showDialog(
      context: context,
      builder: (_) => StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 60.h,
                    width: 80.w,
                    child: ListView.builder(
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () => controller.chooseCity(index),
                              child:cityWidgetModel(cities[index],index));
                        }),
                  )
                ],
              ),
            );
          }));
}

Widget cityWidgetModel(String city,int index) {
  return Container(
    margin: EdgeInsets.symmetric( horizontal: 5.w),
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(7.sp)),
    child: ListTile(
      contentPadding: EdgeInsets.only(right: 3.w),
      leading: Container(
        width: 40.sp,
        height: 40.sp,
        decoration: BoxDecoration(
          color: const Color(0xffF5F7FA),
          borderRadius: BorderRadius.circular(7.sp),
        ),
        child: Center(
          child: Text(
            (index+1).toString(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 9.sp),
          ),
        ),
      ),
      title: Text(
        city,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10.sp),
      ),
    ),
  );
}
