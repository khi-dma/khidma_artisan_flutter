import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:khidma_artisan_flutter/models/model.CommentClient.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../../constWidgets/cashedNetwork.dart';
import '../../../../controllers/Local/controller.theme.dart';

Widget ratingModelWidget(CommentArtisanModel comment) {
  return Card(
    color: ThemeController.backScaffoldGroundColor(),
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.sp),
        side: BorderSide(color: ThemeController.tertiaryColor())),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data:
              Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
          child: ListTile(
            leading: SizedBox(
              height: 40.sp,
              width: 40.sp,
              child: ClipOval(
                child: cachedNetworkModel(comment.artisan.profilePicture),
              ),
            ),
            title: Text(
              comment.artisan.firstName + " " + comment.artisan.lastName,
              style: TextStyle(fontSize: 14.sp),
            ),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar.builder(
                  itemSize: 13.sp,
                  ignoreGestures: true,
                  initialRating: comment.ratingProject,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  onRatingUpdate: (value) {},
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 7.sp,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  comment.ratingProject.toString(),
                  style: TextStyle(
                      fontSize: 13.sp, color: ThemeController.oppositeColor()),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                comment.comment,
                style: TextStyle(fontSize: 13.sp),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    ),
  );
}

Widget rowModel(String title, double initial) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title + " :",
          style: TextStyle(fontSize: 13.sp),
        ),
        RatingBar.builder(
          minRating: 0,
          ignoreGestures: true,
          itemSize: 20.sp,
          initialRating: initial,
          direction: Axis.horizontal,
          itemCount: 5,
          onRatingUpdate: (value) {},
          itemBuilder: (context, _) => Icon(
            Icons.star_rounded,
            color: ThemeController.primaryColor(),
            size: 9.sp,
          ),
        ),
      ],
    ),
  );
}
