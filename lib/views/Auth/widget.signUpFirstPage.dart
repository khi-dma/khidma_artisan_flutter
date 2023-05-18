import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/authControllers/controller.signUp.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../data/font.data.dart';
import '../Components/component.button.dart';
import '../Components/component.input.dart';
import '../Components/component.inputDate.dart';

class SignUpFirstPageWidget extends StatelessWidget {
  SignUpFirstPageWidget(
      {required this.phoneNumber,required this.tokenNotification, required this.tokenSignUp, Key? key})
      : super(key: key);
  String tokenSignUp;
  String phoneNumber;
  String tokenNotification;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        SignUpController(signUpToken: tokenSignUp, phoneNumber: phoneNumber, tokenNotification: tokenNotification));
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Form(
              key: controller.firstFormKey,
              child: SingleChildScrollView(
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
                    SvgPicture.asset("assets/icons/step1.svg"),

                    SizedBox(
                      height: 7.h,
                    ),
                    InputComponent(
                      hintText: 'First name',
                      validate: controller.validatorFirstName,
                      textEditingController: controller.firstNameController,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InputComponent(
                      hintText: 'Last name',
                      validate: controller.validatorLastName,
                      textEditingController: controller.lastNameController,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InputDateComponent(
                      validate: controller.validatorBirthDate,
                      textEditingController: controller.birthDateController,
                      function: controller.changeDate,
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    ToggleSwitch(
                      animationDuration: 400,
                      minWidth: 42.w,
                      minHeight: 6.5.h,
                      initialLabelIndex: 0,
                      cornerRadius: 5.sp,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey.withOpacity(0.2),
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      icons: const [Icons.man_rounded, Icons.woman_rounded],
                      iconSize: 30.0,
                      activeBgColors: const [
                        [Color(0xff425B59)],
                        [Color(0xff425B59)]
                      ],
                      animate: true,
                      // with just animate set to true, default curve = Curves.easeIn
                      curve: Curves.bounceInOut,
                      // animate must be set to true when using custom curve
                      onToggle: controller.updateSexe,
                    ),

                    SizedBox(
                      height: 7.h,
                    ),
                    animatedButton("Next".tr, () => controller.toSecondPage(),
                        controller.btnController),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
