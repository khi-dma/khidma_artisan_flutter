import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.client.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../controllers/Local/controller.theme.dart';
import '../../data/fonc.data.dart';

Widget ratingWidget(ClientModel client) {
  return Card(
    color: ThemeController.backScaffoldGroundColor(),
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.sp),
        side: BorderSide(color: ThemeController.tertiaryColor())
    ),
    child: Padding(
      padding:  EdgeInsets.all(8.sp),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(children: [
              Text((double.parse(client.rating)).toString(),style: TextStyle(fontSize: 40.sp),),
              RatingBar.builder(
                itemSize: 10.sp,
                ignoreGestures: true,
                initialRating: double.parse(client.rating),
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                onRatingUpdate: (value) {},
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 1.sp,
                ),
              ),
            ],),
          ) ,
          SizedBox(width: 2.w,),

          Expanded(
            flex: 7,
            child: Column(
              children: [
                progress("5", percent(client.stars[5]!, client.starsNumber)),
                progress("4", percent(client.stars[4]!, client.starsNumber)),
                progress("3", percent(client.stars[3]!, client.starsNumber)),
                progress("2", percent(client.stars[2]!, client.starsNumber)),
                progress("1", percent(client.stars[1]!, client.starsNumber)),
                progress("0", percent(client.stars[0]!, client.starsNumber)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget progress(String stars, double percent) {
  return Row(
    children: [
      Expanded(child: Center(child: Text(stars))),
      Expanded(
        flex: 20,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: LinearPercentIndicator(
            animation: true,
            lineHeight: 9.sp,
            animationDuration: 500,
            percent: percent,
            barRadius: Radius.circular(30.sp),
            backgroundColor: ThemeController.backgroundColor(),
            progressColor: ThemeController.secondaryColor(),
          ),
        ),
      ),
    ],
  );
}
