import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/errorWidget.dart';
import 'package:khidma_artisan_flutter/constWidgets/progressIndicator.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/IdentityControllers/controller.identityCard.dart';
import '../../controllers/IdentityControllers/controller.verifyIdentity.dart';
import '../../data/font.data.dart';
import '../../data/pallete.data.dart';
import '../Components/component.button.dart';

class VerifyIdentity extends StatelessWidget {
  const VerifyIdentity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyIdentityController());
    return SafeArea(
        child: Scaffold(
      body: Obx(
          ()=> Center(
          child: controller.downloading.value
              ? circularProgressModel()
              : controller.error.value
                  ? errorWidget()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "your card has been sent",
                          style: TextStyle(fontSize: 15.sp, fontWeight: semiBold),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "We will verify your identity card,\n Wait for our response before 24 hours",
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: medium,
                              color: kGreyTextColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        animatedButtonSecondary(
                            "Log out".tr,
                            () => controller.logOut(),
                            controller.logOutButtonController)
                      ],
                    ),
        ),
      ),
    ));
  }
}
