import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import '../../../data/font.data.dart';
import '../../../data/pallete.data.dart';

import 'package:sizer/sizer.dart';

class InputAboutComponent extends StatelessWidget {
  final TextEditingController textEditingController;
  final int maxLines;
  final bool readOnly;

  const InputAboutComponent(
      {Key? key, required this.textEditingController, this.maxLines = 1,required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      maxLines: maxLines,
      cursorColor: kSecondBlueColor,
      controller: textEditingController,
      style: TextStyle(fontSize: 10.sp, fontWeight: regular),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        labelStyle: TextStyle(color: kGreyTextColor, fontSize: 10.5.sp),
        hintStyle: TextStyle(
            fontSize: 10.sp,
            fontWeight: regular,
            color: ThemeController.tertiaryColor()),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: Colors.transparent, width: 1.sp)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: Colors.transparent, width: 1.sp)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: Colors.transparent, width: 0.5.sp)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(color: Colors.transparent, width: 0.5.sp)),
        fillColor: ThemeController.backgroundColor(),
        filled: true,
      ),
    );
  }
}
