import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:khidma_artisan_flutter/data/font.data.dart';
import 'package:khidma_artisan_flutter/data/pallete.data.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../controllers/Identity/controller.identityCard.dart';
import '../Components/component.button.dart';

class UploadIdentityWidget extends StatelessWidget {
  const UploadIdentityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IdentityCardController());
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please upload your identity card",
              style: TextStyle(fontSize: 15.sp, fontWeight: semiBold),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "make sure that the pic is clear\n  and thereis no filter on it ,\n to confirm your account ,\n it will take 24h",
              style: TextStyle(
                  fontSize: 10.sp, fontWeight: medium, color: kGreyTextColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Front side",
                style: TextStyle(fontSize: 12.sp, fontWeight: medium),
              ),
            ),
            Obx(
                ()=> InkWell(
                onTap: ()=>controller.chooseImage(1),
                child: SvgPicture.asset(
                  ThemeController.isThemeDark() ?"assets/icons/uploadImageDark.svg"  :"assets/icons/uploadImage.svg",
                  color: controller.firstImagePath.value.isEmpty
                      ? null
                      : ThemeController.primaryColor(),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Back side",
                style: TextStyle(fontSize: 12.sp, fontWeight: medium),
              ),
            ),
            Obx(()=>InkWell(
                onTap: ()=>controller.chooseImage(2),
                child: SvgPicture.asset(
                  ThemeController.isThemeDark() ?"assets/icons/uploadImageDark.svg"  :"assets/icons/uploadImage.svg",
                  color: controller.secondImagePath.value.isEmpty
                      ? null
                      : ThemeController.primaryColor(),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: double.infinity,
              child: Obx(() => animatedButton(
                  "Send".tr,
                  controller.enable.value ? () => controller.upload() : null,
                  controller.uploadButtonController)),
            ),
            SizedBox(
              height: 2.h,
            ),
            animatedButtonSecondary("Log out".tr, () => controller.logOut(),
                controller.logOutButtonController)
          ],
        ),
      ),
    ));
  }
}
