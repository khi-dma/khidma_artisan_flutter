import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/LocalController/controller.theme.dart';
import '../../../data/font.data.dart';

Widget listTileModel(String title, String icon,double size,Callback function,[color]) {
  return ListTile(
    onTap:function ,
    contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
    minLeadingWidth: 5.w,
    leading: SizedBox(
        height: double.infinity,
        child: SvgPicture.asset(
          "assets/icons/$icon.svg",
          width: size.sp,
          color: icon == "availability" ? color : ThemeController.tertiaryColor(),
        )),
    title: Text(
      title,
      style: TextStyle(fontWeight: medium, fontSize: 12.sp),
    ),
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      size: 12.sp,
    ),
  );
}
