import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/profile/controller.portfolio.dart';
import 'package:khidma_artisan_flutter/models/model.portFolio.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constWidgets/snackBar.dart';
import '../../data/fonc.data.dart';
import '../../services/service.portfolio.dart';

class AddPortfolioController extends GetxController {
  void addPortfolio()async  {
    if (formKey.currentState!.validate()) {
      if (picPath.value.isEmpty) {
        snackBarModel("Picture missing", "Please upload a pic", true);
      }
      PreviousWorkModel previousWork = PreviousWorkModel(
          id: -1,
          title: titleController.text,
          pathPic: picPath.value,
          urlPic: "",
          description: descriptionController.text);
      var res = await  PortfolioService.addPreviousWork(previousWork);
      if(res.error){
        snackBarModel("Failed", "Something went wrong", true);
      }else{
        final portfolioController = Get.find<PortfolioController>();
        portfolioController.portFolio.previousWork.add(res.data);
        Get.back();
        snackBarModel("Success", "Previous work added", false);
      }
      btnController.stop();
    } else {
      btnController.stop();
    }
  }

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final validatorTitle = ValidationBuilder()
      .maxLength(30, "title is too long")
      .minLength(3, "title is too short")
      .build();
  final validatorDescription = ValidationBuilder()
      .maxLength(800, "description is too long")
      .minLength(10, "description is too short")
      .build();


  Color longDescription() {
    return descriptionController.text.length > 800 ||
            descriptionController.text.length < 10
        ? Colors.redAccent
        : Colors.green;
  }

  /////pic
  var picPath = "".obs;

  void takePick() async {
    picPath.value = await takePic(1, 1.2);
  }
}
