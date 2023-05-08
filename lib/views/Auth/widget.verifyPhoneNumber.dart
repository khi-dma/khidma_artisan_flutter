import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/authControllers/controller.login.dart';
import 'package:khidma_artisan_flutter/data/pallete.data.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/font.data.dart';
import '../Components/component.button.dart';

class VerifyPhoneNumberWidget extends StatefulWidget {
  const VerifyPhoneNumberWidget({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneNumberWidget> createState() => _VerifyPhoneNumberWidgetState();
}

class _VerifyPhoneNumberWidgetState extends State<VerifyPhoneNumberWidget> {
  final controller = Get.find<LogInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 7.w),
            child: Column(children: [
              SizedBox(
                height: 5.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 0.1,
                          blurRadius: 10,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/back.svg',
                      height: 35.sp,
                      width: 35.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'verification'.tr,
                style: TextStyle(
                  fontWeight: semiBold,
                  fontSize: 17.sp,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "confirmDesc".tr + "0" + controller.phoneNumberController.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: regular,
                  fontSize: 11.sp,
                  color: ThemeController.tertiaryColor(),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'verificationCode'.tr + " :",
                    style: TextStyle(
                      fontWeight: medium,
                      fontSize: 13.sp,
                    ),
                  )),
              SizedBox(
                height: 1.h,
              ),
              PinCodeTextField(
                autoDisposeControllers: false,
                controller: controller.codeController,
                onSubmitted: (s) {},
                enablePinAutofill: true,
                autovalidateMode: AutovalidateMode.disabled,
                appContext: context,
                length: 6,
                textStyle: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: medium,
                ),
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                cursorColor:ThemeController.oppositeColor(),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                autoFocus: true,
                keyboardType: TextInputType.number,
                cursorWidth: 0.4.w,
                pastedTextStyle: TextStyle(
                    fontSize: 12.sp, fontWeight: medium),
                pinTheme: PinTheme(
                  borderWidth: 1.sp,
                  selectedFillColor: ThemeController.backgroundColor(),
                  selectedColor: kPrimaryColor,
                  activeColor: kPrimaryColor,
                  inactiveColor: kPrimaryColor,
                  activeFillColor: ThemeController.backgroundColor(),
                  inactiveFillColor: ThemeController.backgroundColor(),
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5.sp),
                  fieldHeight: 40.sp,
                  fieldWidth: 34.sp,
                ),
                onChanged: (value) {
                  if(value.length==6){
                    controller.enable.value = true;
                  }
                },
              ),
              SizedBox(
                height: 4.h,
              ),
              Obx(() => animatedButton(
                  "confirm".tr,
                  controller.enable.value ? controller.verifyCode : null,
                  controller.btnController)),
              SizedBox(
                height: 3.h,
              ),
              GetBuilder(
                  init: controller,
                  builder: (context) {
                    if (controller.start == 0) {
                      return InkWell(
                        onTap: () {
                          controller.sendCode(true);
                        },
                        child: Text(
                          'resend'.tr,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: ThemeController.primaryColor(),
                          ),
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'resend_after'.tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ThemeController.tertiaryColor(),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            controller.start.toString() + " " + 'seconds'.tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ThemeController.tertiaryColor(),
                            ),
                          )
                        ],
                      );
                    }
                  }),
              SizedBox(height: 2.h),
            ])));
  }
}
