import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/snackBar.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.local.dart';
import 'package:khidma_artisan_flutter/controllers/profile/controller.profil.dart';
import 'package:khidma_artisan_flutter/services/service.profile.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../models/model.available.dart';
import '../../services/service.auth.dart';

class AvailabilityController extends GetxController {

  var error = false.obs;
   AvailableModel availability=AvailableModel.notNull;
   AvailableModel availabilityBefore=AvailableModel.notNull;

  TextEditingController noteController = TextEditingController();

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    noteController = TextEditingController(text: availability.note);
    getAvailability();
  }

  getAvailability()async  {
    switchState();
    var res= await AuthService.available();
    error.value=res.error;
    availability=res.data;
    availabilityBefore=availability.clone();
    switchState();
  }

  void save() async {
    var error = await ProfileService.updateAvailability(availability);
    if (error) {
      snackBarModel("Failed", "Something went wrong", true);
    } else {
      Get.back();
      snackBarModel("Success", "Availability status updated", false);
    }
    btnController.stop();
  }

  void updateStatus(int? value) {
    availability.schedule.value = value == 0;
  }

  updateAvailabilitySimpleStatus(value) {
    if (availability.schedule.isFalse) {
      availability.available.value = value;
    }
  }

  switchWeekDay(String key) {
    if (availability.schedule.isTrue) {
      availability.weekday[key] = !(availability.weekday[key] ?? true);
      update(["weekday"]);
    }
  }

  void updateReceiveOffersOffline(bool value) {
    availability.receiveOffers.value = value;
  }

  var downloading = false.obs;

  switchState() => downloading.value = !downloading.value;
}
