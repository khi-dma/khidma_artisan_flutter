import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../data/font.data.dart';
import '../../../data/pallete.data.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InputDateComponent extends StatelessWidget {
  TextEditingController textEditingController;
  String? Function(String?) validate;
  Function(DateTime) function;

  InputDateComponent(
      {Key? key,
      required this.textEditingController,
      required this.function,required this.validate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:textEditingController ,
      validator: validate,
      onTap: () {
        Get.bottomSheet(Container(
            height: 40.h,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    maximumYear:
                        DateTime.now().subtract(const Duration(days: 2190)).year,
                    initialDateTime:
                        DateTime.now().subtract(const Duration(days: 2190)),
                    minimumYear:DateTime.now().subtract(const Duration(days: 29190)).year ,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: function,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "save".tr,
                        style: TextStyle(
                            fontWeight: medium,
                            fontSize: 13.sp,
                            color: kPrimaryColor),
                      )),
                )
              ],
            )));
      },
      readOnly: true,
      cursorColor: kPrimaryColor,
      style: TextStyle(fontSize: 10.sp, fontWeight: regular),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 7.w,vertical: 2.3.h),
        hintText: "Birth date",
        labelText: "Birth date",
        labelStyle: TextStyle(color: kGreyTextColor,fontSize: 10.5.sp),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: kSecondBlueColor, width: 1.sp)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: kGreyBackColor,width: 1.sp)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: Colors.redAccent,width: 0.5.sp)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: Colors.redAccent,width: 0.5.sp)),
        fillColor: kGreyBackColor,
        filled: true,
      ),
    );
  }
}
