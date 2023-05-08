import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../constWidgets/appBar.dart';
import '../../constWidgets/cashedNetwork.dart';
import '../../controllers/LocalController/controller.theme.dart';
import '../../controllers/profileControllers/controller.profilController.dart';
import '../Components/component.button.dart';
import '../Components/component.input.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("Edit profile"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.h),
        child: Column(
          children: [
            SizedBox(height: 1.h),
            InkWell(
              onTap: () => controller.takePick(),
              child: SizedBox(
                height: 80.sp,
                width: 80.sp,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.sp),
                      child: Obx(() => controller.picPath.value.isEmpty
                          ? cachedNetworkModel(controller.user.profilePicture)
                          : Image.file(
                              File(controller.picPath.value),
                              fit: BoxFit.contain,
                            )),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: ThemeController.secondaryColor()
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.sp),
                                bottomRight: Radius.circular(5.sp),
                              )),
                          height: 20.sp,
                          width: 80.sp,
                          child: Center(
                            child: Text(
                              "Edit Pic",
                              style: TextStyle(fontSize: 9.sp),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            InputComponent(
                textEditingController: TextEditingController(),
                hintText: "",
                validate: controller.validatorLastName),
            const Spacer(),
            animatedButton("Save", controller.save, controller.btnController)
          ],
        ),
      ),
    ));
  }
}
