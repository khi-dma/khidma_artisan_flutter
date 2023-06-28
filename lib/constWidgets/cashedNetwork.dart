import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:sizer/sizer.dart';

import '../data/pallete.data.dart';


Widget cachedNetworkModel(String? url) {
  if (url == "") {
    return Padding(
      padding: EdgeInsets.all(4.sp),
      child: SvgPicture.asset(
        "assets/images/user.svg",
        fit: BoxFit.contain,
        color: kSecondBlueColor,
      ),
    );
  } else {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Padding(
            padding: EdgeInsets.all(20.sp),
            child: SvgPicture.asset(
              "assets/logo/logo_khidma_artisan.svg",
              fit: BoxFit.contain,
              color: ThemeController.primaryColor(),
            ),
          ),
      errorWidget: (context, url, error) {
          return Padding(
            padding: EdgeInsets.all(20.sp),
            child: SvgPicture.asset(
              "assets/logo/logo_khidma_artisan.svg",
              fit: BoxFit.contain,
              color: ThemeController.primaryColor(),
            ),
          );
      }
    );
  }
}
