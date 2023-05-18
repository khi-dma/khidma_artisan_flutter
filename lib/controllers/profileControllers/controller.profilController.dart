import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constWidgets/snackBar.dart';
import '../../data/fonc.data.dart';
import '../../models/model.user.dart';
import '../../services/service.profile.dart';
import '../../views/Auth/widget.phoneNumber.dart';
import '../../views/dialogbox/dialog.availability.dart';
import '../LocalController/controller.local.dart';
import '../LocalController/controller.theme.dart';

class ProfileController extends GetxController {
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = LocalController.getProfile();
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    birthDateController = TextEditingController(text: user.birthDate);
    sexe = user.sexe == "Homme" ? 0 : 1;
    available.value = LocalController.getAvailability();
  }



  ///// edit profile
  late UserModel user;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  late TextEditingController birthDateController;
  int sexe = 0;

  final validatorFirstName = ValidationBuilder()
      .regExp(RegExp(r'^[a-zA-Z0-9]+$'), "name must be alphabetic")
      .maxLength(50, "please type a true name")
      .minLength(3, "please type a true name")
      .build();

  final validatorLastName = ValidationBuilder()
      .regExp(RegExp(r'^[a-zA-Z0-9]+$'), "name must be alphabetic")
      .maxLength(50, "please type a true name")
      .minLength(3, "please type a true name")
      .build();

  final validatorBirthDate = ValidationBuilder().required().build();

  var modifiedData = {};

  updateSexe(int? index) {
    sexe = index ?? 0;
  }

  /////// pic
  var picPath = "".obs;

  void takePick() async {
    picPath.value = await takePic(1, 1);
  }

  void save() async {
    btnController.start();
    var res = await ProfileService.updatePic(picPath.value);
    if(res.error){
      snackBarModel("Failed", "Something went wrong", true);
    }else{
      LocalController.setProfile(res.data);
      user = LocalController.getProfile();
      Get.back();
      picPath = "".obs;
      update(["picture"]);
      snackBarModel("Success", "Picture changed", false);
    }
    btnController.stop();
  }



  /////// theme
  bool verifyMood(ThemeMode mode) {
    return ThemeController.getThemeMode() == mode;
  }

  changeTheme(String theme, ThemeMode themeMode) {
    ThemeController.setTheme(theme, themeMode);
    //Get.find<BottomBarController>().update();
    Get.back();
  }


  ////// lang
  bool verifyLang(String lang) {
    return LocalController.getLang() == lang;
  }

  changeLang(String lang, Locale locale) {
    LocalController.setLang(lang);
    Get.updateLocale(locale);
    //Get.find<BottomBarController>().update();
    Get.back();
  }

  ////// availability
  availableColor(){
    return  Colors.red.withOpacity(0.7);
  }
  Rx<bool> available = false.obs;

  updateAvailability(bool newValue){
    available.value = newValue;
  }

  showDialog()async{
     await  Get.dialog(dialogAvailability(),barrierColor: Colors.black.withOpacity(0.9));
     if(available.value != LocalController.getAvailability()){
       var error = await ProfileService.updateAvailability();
      if(!error){
        LocalController.setAvailability(available.value);
       }
     }
  }

  logOut(){
    LocalController.clear();
    Get.deleteAll();
    Get.offAll(()=>const LogInWidget());
    btnController.stop();
  }





}
