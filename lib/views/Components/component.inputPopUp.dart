import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/views/Components/popUpCities.dart';
import 'package:khidma_artisan_flutter/views/Components/popUpCommunes.dart';
import 'package:khidma_artisan_flutter/views/Components/popUpServices.dart';
import '../../../data/font.data.dart';
import '../../../data/pallete.data.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/authControllers/controller.signUp.dart';

class InputPopUpComponent extends StatefulWidget {
  TextEditingController textEditingController;
  String? Function(String?) validate;
  String hint;

  InputPopUpComponent(
      {Key? key,
      required this.hint,
      required this.textEditingController,
      required this.validate})
      : super(key: key);

  @override
  State<InputPopUpComponent> createState() => _InputDateComponentState();
}

class _InputDateComponentState extends State<InputPopUpComponent> {
  final controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      validator: widget.validate,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Timer(const Duration(milliseconds: 100), () {
          widget.hint == "City"
              ? showCities(context)
              : widget.hint == "Service"
                  ? showServices(context)
                  : showCommunes(context);
        });
      },
      readOnly: true,
      cursorColor: kPrimaryColor,
      style: TextStyle(fontSize: 10.sp, fontWeight: regular),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.3.h),
        hintText: widget.hint,
        labelText: widget.hint,
        labelStyle: TextStyle(color: kGreyTextColor, fontSize: 10.5.sp),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: kSecondBlueColor, width: 1.sp)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: kGreyBackColor, width: 1.sp)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: Colors.redAccent, width: 0.5.sp)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: Colors.redAccent, width: 0.5.sp)),
        fillColor: kGreyBackColor,
        filled: true,
      ),
    );
  }
}
