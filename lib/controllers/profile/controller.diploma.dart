import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/snackBar.dart';
import 'package:khidma_artisan_flutter/data/fonc.data.dart';
import 'package:khidma_artisan_flutter/models/model.document.dart';
import 'package:khidma_artisan_flutter/services/service.diploma.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../views/Profile/diploma/widget.diplomaDetail.dart';
import '../../views/Profile/diploma/widget.uploadDiploma.dart';
import 'package:flutter/material.dart';

import '../../views/dialogbox/dialog.checkDiploma.dart';
import '../../views/dialogbox/dialog.delete.dart';

class DiplomaController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getDiplomas();
  }

  Rx<bool> downloading = false.obs;
  Rx<bool> error = false.obs;

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  RxList<DocumentModel> diplomas = <DocumentModel>[].obs;

  getDiplomas() async {
    switchState();
    var res = await DiplomaService.getDiploma();
    error.value = res.error;
    if (!error.value) {
      diplomas.value = res.data;
    }
    switchState();
  }

  switchState() {
    downloading.value = !downloading.value;
  }

  ///// add diploma
  Rx<String> path = "".obs;

  void choosePic() async {
    path.value = await takePic(null, null);
    if(path.value.isNotEmpty){
      Get.dialog(uploadDiplomaWidget(),
          barrierDismissible: false, barrierColor: Colors.black.withOpacity(0.9));
    }

  }


  upload()async{
    var res = await DiplomaService.addPreviousWork(path.value);
    if(res.error){
      snackBarModel("Filed", "Something went wrong", true);
    }else{
      Get.back();
      diplomas.add(res.data);
      Get.dialog(dialogBoxCheckDiploma(),barrierDismissible: false);
    }
    btnController.stop();
  }

  toDetail(int index){
    Get.dialog(DetailDiplomaWidget(index: index));
  }

  delete(int index)async{
    Get.dialog(dialogBoxDelete(()async{
      Get.back();
      Get.back();
      var error =await DiplomaService.deleteDiploma(diplomas[index].id);
      if(error){
        snackBarModel("Failed", "Something went wrong", true);
      }else{
        snackBarModel("Success", "Diploma deleted successfully", false);
        diplomas.removeAt(index);
      }
    }));
  }

  IconData icon(int index){
    switch( diplomas[index].state){
      case 0:{
        return Icons.check;
      }
      case 1:{
        return Icons.access_time;
      }
      case 2:{
        return Icons.clear;
      }
      default:{
        return Icons.clear;
      }
    }
  }




}
