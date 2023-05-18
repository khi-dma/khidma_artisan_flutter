import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/cashedNetwork.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/PostsControllers/controller.post.dart';
import 'package:khidma_artisan_flutter/data/font.data.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:khidma_artisan_flutter/views/Posts/widget.request.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/PostsControllers/controller.abstractClass.dart';

Widget postWidgetModel(int index, PostAbstractClassController controller) {
  PostModel post = controller.posts[index];
  return Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    child: Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
          leading: SizedBox(
            height: 30.sp,
            width: 30.sp,
            child: ClipOval(
              child: cachedNetworkModel(post.userClient.profilePicture),
            ),
          ),
          title: Text(
            post.userClient.name,
            style: TextStyle(fontWeight: medium, fontSize: 12.sp),
          ),
          subtitle: Text(
            post.date.toString()+ "  - "+post.city+" "+post.municipal+"",
            style: TextStyle(
                fontSize: 10.sp, color: ThemeController.secondaryColor()),
          ),
          trailing: Icon(Icons.more_horiz_rounded,
              size: 23.sp, color: ThemeController.secondaryColor()),
        ),
        InkWell(
          onTap: () => controller.toRequest(index),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: TextStyle(fontSize: 12.sp, fontWeight: regular),
                ),
                ExpandableText(
                  post.description,
                  expandText: 'show more',
                  maxLines: 2,
                  linkColor: ThemeController.secondaryColor(),
                  animationDuration: const Duration(milliseconds: 700),
                  animation: true,
                  collapseOnTextTap: true,
                  style: TextStyle(fontSize: 11.sp, fontWeight: light),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          width: double.infinity,
          child: cachedNetworkModel(post.urlPic),
        ),
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: [
              Text(
                post.requestsNumber.toString() + " " + "requests",
                style: TextStyle(fontSize: 12.sp),
              ),
              const Spacer(),
              Obx(
                () => InkWell(
                  onTap: () => controller.switchSave(index),
                  child: SvgPicture.asset(
                    "assets/icons/" +
                        (post.saved.value ? "save.svg" : "saveNotSolid.svg"),
                    color: ThemeController.oppositeColor(),
                    height: 17.sp,
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              InkWell(
                onTap: () => controller.toRequest(index),
                child: Row(
                  children: [
                    Obx(
                      () => SvgPicture.asset(
                        "assets/icons/message.svg",
                        color: ThemeController.oppositeColor().withOpacity(
                            post.offered || post.requested.value ? 0.3 : 1),
                        height: 17.sp,
                      ),
                    ),
                  ],
                ),
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
