import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import '../../../data/font.data.dart';
import '../../../data/pallete.data.dart';

import 'package:sizer/sizer.dart';

class InputComponent extends StatelessWidget {
  final String hintText;
  final  String? label;
  final TextEditingController textEditingController;
  final String? Function(String?)? validate;
  final Function(String?)? change;
  final int maxLines;
  final bool readOnly;
  final bool labelShow;

  const InputComponent(
      {Key? key, this.label,
        this.readOnly=false,
      this.change,
      required this.textEditingController,
      required this.hintText,
       this.validate,
      this.maxLines = 1,this.labelShow=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onChanged: change,
      maxLines: maxLines,
      validator: validate,
      cursorColor: kSecondBlueColor,
      controller: textEditingController,
      style: TextStyle(fontSize: 12.sp, fontWeight: regular,color: ThemeController.oppositeColor().withOpacity(readOnly?0.3:1)),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
        hintText: hintText,
        labelText: labelShow ? label ?? hintText:null,
        labelStyle: TextStyle(color: kGreyTextColor, fontSize: 12.sp),
        hintStyle:TextStyle(fontSize: 12.sp, fontWeight: regular,color: ThemeController.tertiaryColor()) ,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(
                color: ThemeController.tertiaryColor(), width: 1.sp)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(
                color: ThemeController.tertiaryColor(), width: 1.sp)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(
                color: ThemeController.tertiaryColor(), width: 0.5.sp)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(
                color: ThemeController.tertiaryColor(), width: 0.5.sp)),
        fillColor: ThemeController.backgroundColor(),
        filled: true,
      ),
    );
  }
}
