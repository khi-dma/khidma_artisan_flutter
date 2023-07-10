import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khidma_artisan_flutter/views/Auth/widget.phoneNumber.dart';
import 'package:khidma_artisan_flutter/views/Auth/widget.verifyPhoneNumber.dart';
import 'package:khidma_artisan_flutter/views/Wrapper/widget.wrapper.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constWidgets/snackBar.dart';
import '../../services/service.auth.dart';
import '../../views/Auth/widget.signUpFirstPage.dart';
import '../Local/controller.local.dart';

class LogInController extends GetxController {
  var enable = false.obs;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  int start = 60;
  late Timer timer;
  String verificationId = "";
  late String tokenNotification;
  var fbm = FirebaseMessaging.instance;

  getTokenNotification() {
    fbm.getToken().then((token) {
      tokenNotification = token ?? "";
    });
  }

  @override
  void onInit() async {
    getTokenNotification();
    super.onInit();
  }

  String? changePhoneNumber(String? value) {
    if (phoneNumberController.text == "0") {
      phoneNumberController.clear();
    }
    if (phoneNumberController.text.length == 9) {
      enable.value = true;
      update();
    } else {
      enable.value = false;
      update();
    }
    return "";
  }

  sendCode(bool resend) async {
    startTimer();
    if (resend) {
      btnController.reset();
    }
    codeController.clear();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+213${phoneNumberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        snackBarModel("Failed".tr, e.toString(), true);
        btnController.error();
        Timer(const Duration(milliseconds: 300), () {
          btnController.reset();
        });
      },
      timeout: const Duration(seconds: 120),
      codeSent: (String verificationId, int? resendToken) async {

        btnController.success();
        this.verificationId = verificationId;
        Timer(const Duration(milliseconds: 300), () {
          btnController.reset();
          if (!resend) {
            Get.to(() =>  const VerifyPhoneNumberWidget());
            enable.value = false;
          }
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyCode() async {
    var res = await AuthService.verifyCode(phoneNumberController.text,
        codeController.text, verificationId, tokenNotification);
    if (res.error) {
      snackBarModel("Failed".tr, res.returnMessage, true);
    } else {
      if (res.exist) {
        if (res.state != 1) {
          LocalController.setProfile(res.data);
          LocalController.setToken(res.token);
          LocalController.setState(res.state);
          Get.offAll(() => const WrapperWidget());
        } else {
          snackBarModel(
              "Failed", "Your account is desactivated by the admin", true);
        }
      } else {
        Get.off(() => SignUpFirstPageWidget(
              phoneNumber: phoneNumberController.text,
              tokenSignUp: res.token,
              tokenNotification: tokenNotification,
            ));
      }
    }
    btnController.stop();

  }

  void startTimer() {
    start = 60;
    update();
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          update();
        } else {
          start--;
          update();
        }
      },
    );
  }


}
