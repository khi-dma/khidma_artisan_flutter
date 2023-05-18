import 'package:flutter/material.dart';
import '../../../data/font.data.dart';
import '../../../data/pallete.data.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/LocalController/controller.theme.dart';

class InputChat extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback function;

  const InputChat({Key? key, required this.textEditingController, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kSecondBlueColor,
      controller: textEditingController,
      style: TextStyle(fontSize: 12.sp, fontWeight: regular),
      decoration: InputDecoration(
        suffixIcon: InkWell(
            onTap: function,
            child:  Icon(
              Icons.send,
              color: ThemeController.tertiaryColor(),
            )),
        contentPadding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
        hintText: "Message",
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.sp)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.sp)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.5.sp)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.5.sp)),
        fillColor: ThemeController.backgroundColor(),
        filled: true,
      ),
    );
  }
}
