import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/services/service.auth.dart';
import 'package:khidma_artisan_flutter/views/Auth/widget.phoneNumber.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../views/BottomBar/widget.bottomBar.dart';
import '../../views/Wrapper/widget.wrapper.dart';
import '../Local/controller.local.dart';

class VerifyIdentityController extends GetxController {
  final RoundedLoadingButtonController logOutButtonController =
  RoundedLoadingButtonController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUser();
  }

  var error = false.obs;
  var downloading = false.obs;

  switchState() {
    downloading.value = !downloading.value;
  }

  getUser() async {
    switchState();
    var res = await AuthService.me();
    if (!res.error) {
      LocalController.setState(res.state);
      LocalController.setProfile(res.data);
      if (res.state == 0) {
        Get.offAll(() => const WrapperWidget());
      }else if(res.state == 4){
        Get.offAll(() => const WrapperWidget());
      }
    }
    switchState();
  }

  logOut() {
    LocalController.clear();
    Get.deleteAll();

    Get.offAll(() => const WrapperWidget());
    logOutButtonController.stop();
  }

}
