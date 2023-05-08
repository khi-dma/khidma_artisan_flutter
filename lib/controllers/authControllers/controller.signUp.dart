import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.service.dart';
import 'package:khidma_artisan_flutter/views/Identity/widget.uploadIdentity.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';

import '../../constWidgets/snackBar.dart';
import '../../data/const.data.dart';
import '../../data/constCities.data.dart';
import '../../models/model.user.dart';
import '../../services/service.auth.dart';
import '../../views/Auth/widget.signUpSecondPage.dart';
import '../LocalController/controller.local.dart';

class SignUpController extends GetxController {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  GlobalKey<FormState> firstFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> secondFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController municipalController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  int sexe = 0;
  int indexCity = 0;
  late ServiceModel service;

  String signUpToken;
  String phoneNumber;
  String tokenNotification;

  SignUpController(
      {required this.signUpToken,
      required this.phoneNumber,
      required this.tokenNotification});

  final validatorFirstName = ValidationBuilder()
      .regExp(RegExp(r'^[a-zA-Z]+$'), "name must be alphabetic")
      .maxLength(50, "please type a true name")
      .minLength(3, "please type a true name")
      .build();
  final validatorLastName = ValidationBuilder()
      .regExp(RegExp(r'^[a-zA-Z]+$'), "name must be alphabetic")
      .maxLength(50, "please type a true name")
      .minLength(3, "please type a true name")
      .build();
  final validatorCity = ValidationBuilder().required().build();
  final validatorCommune = ValidationBuilder().required().build();
  final validatorService = ValidationBuilder().required().build();
  final validatorBirthDate = ValidationBuilder().required().build();

  currentCommune() {
    return communes
        .where((commune) =>
            int.parse(commune["wilaya_code"].toString()) == indexCity)
        .map((commune) => commune["commune_name"])
        .toList();
  }

  updateSexe(int? index) {
    sexe = index ?? 0;
  }

  void changeDate(DateTime dateTime) {
    final DateTime date = dateTime;
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    birthDateController.text = formatted.toString();
  }

  chooseCity(int index) {
    Get.back();
    cityController.text = cities[index];
    indexCity = index + 1;
    update();
  }

  chooseCommune(int index) {
    Get.back();
    municipalController.text = currentCommune()[index];
    update();
  }

  signUp() async {
    if (secondFormKey.currentState?.validate() ?? true) {
      UserModel user = UserModel(
        uidFirebase: LocalController.getUid(),
        firstName: firstNameController.text,
        tokenNotification: tokenNotification,
        profilePicture: '',
        sexe: sexe.toString(),
        phoneNumber: phoneNumber,
        city: cityController.text,
        birthDate: birthDateController.text,
        lastName: lastNameController.text,
        available: true,
        graduated: false,
        service: service,
        municipal: municipalController.text,
        rating: "",
      );
      var res = await AuthService.signUp(user, signUpToken);
      if (res.error) {
        snackBarModel("Failed".tr, res.returnMessage, true);
        btnController.stop();
      } else {
        LocalController.setState(2);
        LocalController.setToken(res.token);
        Get.offAll(() => const UploadIdentityWidget());
        btnController.success();
      }
    } else {
      btnController.stop();
    }
  }

  toSecondPage() {
    if (firstFormKey.currentState?.validate() ?? true) {
      btnController.stop();
      Get.to(() => const SignUpSecondPageWidget());
    } else {
      btnController.stop();
    }
  }

  chooseService(int index) {
    Get.back();
    service = services[index];
    serviceController.text = services[index].name;
  }
}
