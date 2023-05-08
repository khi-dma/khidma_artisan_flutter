import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.local.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var profile = LocalController.getProfile();
  }
}