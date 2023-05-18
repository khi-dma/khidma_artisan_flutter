import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:lottie/lottie.dart';

import 'package:sizer/sizer.dart';

import '../data/font.data.dart';

Widget emptyListWarning( ) {
  return Center(
    child: Column(
      children: [
        SizedBox(height: 20.h,),
        LottieBuilder.asset("assets/animations/79572-empty-state.json",height: 130.sp,),
        Text(
          "There are no items",
          style: TextStyle(
              fontSize: 11.sp,
              fontWeight: semiBold,
              color: ThemeController.oppositeColor()),
        ),
      ],
    ),
  );
}