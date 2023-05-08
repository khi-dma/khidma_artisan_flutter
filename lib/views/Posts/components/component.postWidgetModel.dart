import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/cashedNetwork.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/PostsControllers/controller.post.dart';
import 'package:khidma_artisan_flutter/data/font.data.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:sizer/sizer.dart';

Widget postWidgetModel(int index, bool showSend) {
  final controller = Get.find<PostController>();
  PostModel post = controller.posts[index];

  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.sp),
    ),

    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
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
              post.date.toString(),
              style: TextStyle(
                  fontSize: 10.sp, color: ThemeController.tertiaryColor()),
            ),
            trailing: Icon(
              Icons.more_horiz_rounded,
              size: 23.sp,
            ),
          ),
          SizedBox(height: 0.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.sp,
                  width: 70.sp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.sp),
                    child: cachedNetworkModel(post.urlPic),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: TextStyle(fontSize: 13.sp, fontWeight: regular),
                      ),
                      Text(
                        post.city + " ," + post.municipal,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: ThemeController.tertiaryColor()),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.4.h),
          ExpandableText(
            post.description,
            expandText: 'show more',
            maxLines: 2,
            linkColor: ThemeController.primaryColor(),
            animationDuration: const Duration(milliseconds: 700),
            animation: true,
            collapseOnTextTap: true,
            style: TextStyle(fontSize: 9.5.sp, fontWeight: light),
          ),
          SizedBox(height: 1.5.h),
          const Divider(
            height: 0,
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Text(
                post.requests.toString() + " " + "requests",
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
              Visibility(
                visible: showSend,
                child: Row(
                  children: [
                    SizedBox(width: 5.w),
                    SvgPicture.asset(
                      "assets/icons/message.svg",
                      color: ThemeController.oppositeColor(),
                      height: 17.sp,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
