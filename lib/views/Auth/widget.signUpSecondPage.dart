import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/authControllers/controller.signUp.dart';
import 'package:sizer/sizer.dart';

import '../../data/font.data.dart';
import '../Components/component.button.dart';
import '../Components/component.inputPopUp.dart';

class SignUpSecondPageWidget extends StatelessWidget {
  const SignUpSecondPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Form(
              key: controller.secondFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    "Welcome to Khidma",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  SvgPicture.asset("assets/icons/step2.svg"),

                  SizedBox(
                    height: 7.h,
                  ),
                  InputPopUpComponent(
                    hint: "Service",
                    validate: controller.validatorService,
                    textEditingController: controller.serviceController,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InputPopUpComponent(
                    hint: "City",
                    validate: controller.validatorCity,
                    textEditingController: controller.cityController,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  GetBuilder(
                    init: controller,
                    builder: (context) {
                      return Visibility(
                        visible: controller.cityController.text.isNotEmpty,
                        child: InputPopUpComponent(
                          hint: "Commune",
                          validate: controller.validatorCommune,
                          textEditingController: controller.municipalController,
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  animatedButton("Sign up".tr, () => controller.signUp(),
                      controller.btnController),
                ],
              ),
            ),
          ),
        ));
  }
}
