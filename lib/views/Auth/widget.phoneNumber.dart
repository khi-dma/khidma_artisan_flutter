import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khidma_artisan_flutter/controllers/authControllers/controller.login.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/data/font.data.dart';
import 'package:khidma_artisan_flutter/data/pallete.data.dart';
import 'package:sizer/sizer.dart';

import '../Components/component.button.dart';
import '../Components/component.inputPhoneNumberLogIn.dart';

class LogInWidget extends StatelessWidget {
  const LogInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogInController());
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            SvgPicture.asset(
              "assets/logo/logo_khidma_artisan.svg",
              height: 80.sp,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Welcome back",
              style: TextStyle(fontSize: 19.sp, fontWeight: semiBold),
            ),
            SizedBox(
              height: 0.h,
            ),
            Text(
              "Use your phone number to log in",
              style: TextStyle(fontSize: 12.sp, fontWeight: medium,color: kGreyTextColor),
            ),
            SizedBox(
              height: 6.h,
            ),
            InputPhoneNumberAuth(
              change: controller.changePhoneNumber,
              textEditingController: controller.phoneNumberController,
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: double.infinity,
              child: Obx(() => animatedButton(
                  "Send".tr,
                  controller.enable.value
                      ? () => controller.sendCode(false)
                      : null,
                  controller.btnController)),
            ),
          ],
        ),
      ),
    ));
  }
}
