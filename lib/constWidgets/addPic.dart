import 'package:flutter_svg/svg.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:sizer/sizer.dart';

addPicModel() => SvgPicture.asset(
   ThemeController.isThemeDark() ? "assets/icons/addPicDark.svg": "assets/icons/addPic.svg",
  height: 80.sp,
  width: 80.sp,
);