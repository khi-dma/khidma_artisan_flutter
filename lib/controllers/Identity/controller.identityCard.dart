import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.local.dart';
import 'package:khidma_artisan_flutter/services/service.auth.dart';
import 'package:khidma_artisan_flutter/views/Wrapper/widget.wrapper.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constWidgets/snackBar.dart';
import '../../views/Identity/widget.verifyIdentity.dart';

class IdentityCardController extends GetxController{
  final RoundedLoadingButtonController uploadButtonController =
  RoundedLoadingButtonController();
  final RoundedLoadingButtonController logOutButtonController =
  RoundedLoadingButtonController();

  late File firstImageFile;
  var firstImagePath = "".obs;
  var secondImagePath ="".obs;
  late File secondImageFile;

  chooseImage(int index)async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);
      if (image != null) {
        if(index==1){
          firstImageFile=File(image.path);
          firstImagePath.value=image.path;
        }else{
          secondImageFile = File(image.path);
          secondImagePath.value = image.path;
        }
      }
      if(secondImagePath.isNotEmpty && firstImagePath.isNotEmpty){
        enable.value=true;
      }
  }

  var enable = false.obs;


  upload()async  {
   var res = await  AuthService.uploadFiles(firstImagePath.value, secondImagePath.value);
   if(res.error){
     snackBarModel("Failed".tr, "Something went wrong", true);
   }else{
     LocalController.setState(3);
     snackBarModel("Success".tr, "Files uploaded", false);
   }
   uploadButtonController.stop();
   Get.offAll(()=>const VerifyIdentity());
  }

  logOut()async {
    var res = await AuthService.logOut();
    if(!res.error){
      Get.offAll(()=>const WrapperWidget());

    }
  }

}