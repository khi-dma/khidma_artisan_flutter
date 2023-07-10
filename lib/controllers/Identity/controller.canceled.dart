import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.document.dart';
import 'package:khidma_artisan_flutter/services/service.auth.dart';
import 'package:khidma_artisan_flutter/views/Auth/widget.phoneNumber.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../views/BottomBar/widget.bottomBar.dart';
import '../../views/Wrapper/widget.wrapper.dart';
import '../Local/controller.local.dart';


class CanceledIdentityController extends GetxController {
  RoundedLoadingButtonController logOutButtonController=RoundedLoadingButtonController();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCause();
  }
  List<DocumentModel> documents=[];
  var error = false.obs;
  var downloading = false.obs;

  switchState() {
    downloading.value = !downloading.value;
  }

  getCause() async {
    switchState();
    var res = await AuthService.cause();
    error.value=res.error;
    if (!res.error) {
      documents=res.data;
    }
    switchState();
  }

  logOut()async {
    LocalController.clear();
    Get.deleteAll();

    Get.offAll(() => const WrapperWidget());
    logOutButtonController.stop();

  }
}
