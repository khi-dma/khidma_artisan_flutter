import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sizer/sizer.dart';

import '../../../constWidgets/decoration.dart';
import '../../../controllers/Local/controller.theme.dart';

Container searchBar() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 2.3.h, horizontal: 7.w),
    decoration: defaultDecoration(4, ThemeController.backgroundColor(),
        ThemeController.getThemeMode() != ThemeMode.dark),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Search by name or service",
          style: TextStyle(fontSize: 10.sp, color: ThemeController.tertiaryColor()),
        ),
        SvgPicture.asset("assets/icons/search.svg",color: ThemeController.tertiaryColor(),)
      ],
    ),
  );
}
