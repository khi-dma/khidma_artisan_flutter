import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:khidma_artisan_flutter/data/font.data.dart';
import 'package:khidma_artisan_flutter/data/pallete.data.dart';
import 'package:khidma_artisan_flutter/views/Identity/widget.uploadIdentity.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../constWidgets/errorWidget.dart';
import '../../constWidgets/progressIndicator.dart';
import '../../controllers/Identity/controller.canceled.dart';
import '../../controllers/Identity/controller.identityCard.dart';
import '../Components/component.button.dart';

class CanceledIdentityWidget extends StatelessWidget {
  const CanceledIdentityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CanceledIdentityController());
    return SafeArea(
        child: Scaffold(
      body: Obx(
        () => Center(
          child: controller.downloading.value
              ? circularProgressModel()
              : controller.error.value
                  ? errorWidget()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Rejected",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.sp),
                            ),
                          ),
                          SizedBox(height: 4.h,),
                          Text(
                            "Front side :",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(controller.documents[0].state == 0
                              ? "accepted"
                              : "rejected : " + controller.documents[0].cause),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "Back side",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(controller.documents[1].state == 0
                              ? "accepted"
                              : "rejected : " + controller.documents[1].cause),
                          SizedBox(
                            height: 4.h,
                          ),
                          button(
                              "Upload Again",
                              () =>
                                  Get.off(() => const UploadIdentityWidget())),
                          SizedBox(
                            height: 2.h,
                          ),
                          animatedButtonSecondary(
                              "Log out".tr,
                              () => controller.logOut(),
                              controller.logOutButtonController)
                        ],
                      ),
                    ),
        ),
      ),
    ));
  }
}
