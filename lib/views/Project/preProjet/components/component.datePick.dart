import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/LocalController/controller.theme.dart';
import '../../../../data/font.data.dart';

Widget datePicker(Function(DateTime) function,DateTime initial,DateTime minimal){
  return Container(
      height: 40.h,
      color: ThemeController.backgroundColor(),
      child: Column(
        children: [
          Expanded(
            child: CupertinoDatePicker(
              initialDateTime:initial,
              minimumDate:minimal ,
              mode: CupertinoDatePickerMode.dateAndTime,
              onDateTimeChanged: function,
            ),
          ),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Save".tr,
                style: TextStyle(
                    fontWeight: medium,
                    fontSize: 15.sp,
                    color: ThemeController.primaryColor()),
              )),
          SizedBox(height: 3.h,)
        ],
      ));
}