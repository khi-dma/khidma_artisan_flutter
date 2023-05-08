import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/snackBar.dart';
import 'package:khidma_artisan_flutter/models/model.portFolio.dart';
import 'package:khidma_artisan_flutter/services/service.portfolio.dart';
import '../../constWidgets/toast.dart';
import '../../views/Profile/Portfolio/widget.previousWorkDetail.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PortfolioController extends GetxController {
  PortfolioModel portFolio = PortfolioModel.notNull;
  var error = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPortFolio();
  }

  getPortFolio() async {
    switchState();
    var res = await PortfolioService.getPortfolio();
    if (res.error) {
      error.value = true;
    } else {
      portFolio = res.data;
      aboutController = TextEditingController(text: portFolio.description);
    }
    switchState();
  }

  var downloading = false.obs;

  switchState() {
    downloading.value = !downloading.value;
  }

  Rx<PreviousWorkModel> currentWork = PreviousWorkModel.notNull.obs;

  late int currentIndex;
  Rx<bool> showDetails = true.obs;

  toDetail(int currentIndex) {
    this.currentIndex = currentIndex;
    currentWork.value = portFolio.previousWork[currentIndex];
    Get.to(() => const PreviousWorkDetail(), transition: Transition.cupertino);
  }

  switchShow() {
    showDetails.value = !showDetails.value;
  }

  Rx<bool> deleting = false.obs;

  deletePWork() async {
    Get.back();
    Get.back();
    switchDeleting();
    bool error =
        await PortfolioService.deletePreviousWork(currentWork.value.id);
    if (error) {
      snackBarModel("Filed", "Something went wrong", true);
    } else {
      portFolio.previousWork.removeAt(currentIndex);
      snackBarModel("Success", "Previous work deleted", false);
    }
    switchDeleting();
  }

  switchDeleting() {
    deleting.value = !deleting.value;
  }

  /////// description
  TextEditingController aboutController = TextEditingController();

  Rx<bool> readOnly = true.obs;
  Rx<bool> edit = false.obs;

  switchEdit() {
    edit.value = !edit.value;
    readOnly.value = !readOnly.value;
  }

  clear() {
    switchEdit();
    aboutController.text = portFolio.description;
  }

  save() async {
    if (aboutController.text != portFolio.description &&
        aboutController.text.isNotEmpty) {
      switchEdit();
      var error =
          await PortfolioService.updateDescription(aboutController.text);
      if (error) {
        aboutController.text = portFolio.description;
        toast("Something went wrong");
      } else {
        toast("updated successfully");
      }
    }
  }

  updateWork(String title, String description) {
    portFolio.previousWork[currentIndex]
      ..title = title
      ..description = description;
    currentWork.value = PreviousWorkModel(
        id: currentWork.value.id,
        title: title,
        description: description,
        pathPic: currentWork.value.pathPic,
        urlPic: currentWork.value.urlPic);
  }
}
