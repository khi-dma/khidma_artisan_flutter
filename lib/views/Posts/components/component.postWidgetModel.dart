import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/cashedNetwork.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:khidma_artisan_flutter/data/font.data.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:khidma_artisan_flutter/views/Client/widget.clientDetail.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/Posts/controller.abstractClass.dart';
import 'package:flutter_animated_icons/flutter_animated_icons.dart';

Widget postWidgetModel(int index, PostAbstractClassController controller) {
  PostModel post = controller.posts[index];
  return Card(
    color: ThemeController.isThemeDark()
        ? ThemeController.backScaffoldGroundColor()
        : ThemeController.backgroundColor(),
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    child: Column(
      children: [
        ListTile(
          onTap: ()=>Get.to(()=>ClientDetailWidget(client: post.userClient)),
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
            post.date.toString() +
                "  - " +
                post.city +
                " " +
                post.municipal +
                "",
            style: TextStyle(
                fontSize: 10.sp, color: ThemeController.secondaryColor()),
          ),
          trailing: Icon(Icons.more_horiz_rounded,
              size: 23.sp, color: ThemeController.secondaryColor()),
        ),
        Padding(
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
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          width: double.infinity,
          child: cachedNetworkModel(post.urlPic,true),
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
            ],
          ),
        ),
        Divider(),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => controller.openMap(index),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/address.svg",
                    color: ThemeController.secondaryColor(),
                    height: 15.sp,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    "address",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ThemeController.secondaryColor(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.w),
            InkWell(
              onTap: () => controller.switchSave(index),
              child: Row(
                children: [
                  Obx(
                    () => SvgPicture.asset(
                      "assets/icons/" +
                          (post.saved.value ? "save.svg" : "saveNotSolid.svg"),
                      color: ThemeController.secondaryColor(),
                      height: 15.sp,
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    "save",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ThemeController.secondaryColor(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.w),
            InkWell(
              onTap: () => controller.toRequest(index),
              child: Obx(
                () => Opacity(
                  opacity: post.requested.value || post.offered ? 0.3 : 1,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/message.svg",
                        color: ThemeController.secondaryColor(),
                        height: 15.sp,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        "request",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: ThemeController.secondaryColor(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    ),
  );
}
