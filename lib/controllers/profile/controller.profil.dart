import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constWidgets/snackBar.dart';
import '../../data/constCities.data.dart';
import '../../data/fonc.data.dart';
import '../../models/model.user.dart';
import '../../services/service.profile.dart';
import '../../views/Auth/widget.phoneNumber.dart';
import '../Local/controller.local.dart';
import '../Local/controller.theme.dart';

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
    cityController = TextEditingController(text: user.city);
    municipalController = TextEditingController(text: user.municipal);
    serviceController = TextEditingController(text: user.service.name);
    sexe = user.sexe == "Homme" ? 0 : 1;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    updated.value=false;
    picPath.value="";
  }

  void save() async {
    btnController.start();
    changes();

    if(picPath.value.isNotEmpty){
      var res = await ProfileService.updatePic(picPath.value);
      if (res.error) {
        snackBarModel("Failed", "Something went wrong", true);
        btnController.stop();
        return ;
      }else{
        LocalController.setProfile(res.data);
      }
    }
    if(modifiedData.isNotEmpty){
      var res = await ProfileService.updateUser(modifiedData);
      if (res.error) {
        snackBarModel("Failed", "Something went wrong", true);
        btnController.stop();
        return ;
      }else{
        LocalController.setProfile(res.data);
      }
    }
    update(["personalInformation"]);
    user = LocalController.getProfile();
    Get.back();
    picPath = "".obs;
    snackBarModel("Success", "Picture changed", false);
    btnController.stop();
  }



  ///// edit profile
  late UserModel user;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController cityController;
  late TextEditingController municipalController;
  late TextEditingController birthDateController;
  late TextEditingController serviceController;
  int sexe = 0;

  int indexCity=0;
  chooseCity(int index) {
    Get.back();
    cityController.text = cities[index];
    indexCity = index + 1;
    municipalController.text = currentCommune()[0];
    change();
    update();
  }

  chooseCommune(int index) {
    Get.back();
    municipalController.text = currentCommune()[index];
    change();
    update();
  }

  currentCommune() {
    return communes
        .where((commune) =>
    int.parse(commune["wilaya_code"].toString()) == indexCity)
        .map((commune) => commune["commune_name"])
        .toList();
  }

  var modifiedData = {};

  updateSexe(int? index) {
    sexe = index ?? 0;
  }

  /////// pic
  var picPath = "".obs;

  void takePick() async {
    picPath.value = await takePic(1, 1);
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

  /*showDialog()async{
     await  Get.dialog(dialogAvailability(),barrierColor: Colors.black.withOpacity(0.9));
     if(available.value != LocalController.getAvailability()){
       var error = await ProfileService.updateAvailability();
      if(!error){
        LocalController.setAvailability(available.value);
       }
     }
  }*/

  logOut(){
    LocalController.clear();
    Get.deleteAll();
    Get.offAll(()=>const LogInWidget());
    btnController.stop();
  }

  var updated = false.obs;

  change() {
    updated.value=false;
    if (user.city != cityController.text ||
        user.municipal != municipalController.text ) {
      updated.value = true;
    }
  }

  changes(){
    if(user.city != cityController.text ){
      modifiedData["city"]=cityController.text;
    }
    if(user.municipal != municipalController.text){
      modifiedData["municipal"]=municipalController.text;
    }
  }


}
