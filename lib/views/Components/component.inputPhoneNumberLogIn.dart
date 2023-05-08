import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import '../../../data/font.data.dart';
import '../../../data/pallete.data.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InputPhoneNumberAuth extends StatelessWidget {
  TextEditingController textEditingController;
  String? Function(String?) change;

  InputPhoneNumberAuth(
      {
        required this.textEditingController,
        required this.change});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: change,
      cursorColor: kPrimaryColor,
      controller: textEditingController,
      keyboardType: TextInputType.number,
      autofocus: true,
      style:
      TextStyle(fontSize: 13.sp, fontWeight: regular),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 2.h),
        prefixIconConstraints: BoxConstraints(maxHeight: 24.h, maxWidth: 70.w),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 12.sp,
          maxWidth: 50.w,
        ),
        prefixIcon: IntrinsicHeight(
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              width: 5.5.w,
            ),
            Text(
              "+213",
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(
              width: 3.w,
            ),
            VerticalDivider(
              thickness: 1.sp,
              color: kBlackColor,
            ),
            SizedBox(
              width: 3.w,
            ),
          ]),
        ),
        filled: true,
        fillColor: ThemeController.backgroundColor(),
        hintText: "Phone_number".tr,
        hintStyle: TextStyle(fontSize: 10.sp),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBlackColor, width: 1.sp),
          borderRadius: BorderRadius.circular(7.sp),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(7.sp),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(7.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(7.sp),
        ),
      ),
    );
  }
}
