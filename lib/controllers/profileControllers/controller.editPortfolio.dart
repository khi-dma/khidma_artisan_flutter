import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/profileControllers/controller.portfolio.dart';
import 'package:khidma_artisan_flutter/models/model.portFolio.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constWidgets/snackBar.dart';
import '../../data/fonc.data.dart';
import '../../services/service.portfolio.dart';

class EditPortfolioController extends GetxController {
  late PreviousWorkModel previousWork;

  EditPortfolioController() {
    final controller = Get.find<PortfolioController>();
    previousWork = controller.currentWork.value;
  }

  Map modifiedData = {};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    titleController = TextEditingController(text: previousWork.title);
    descriptionController =
        TextEditingController(text: previousWork.description);
  }

  void editPortfolio() async {
    if (formKey.currentState!.validate()) {
      if (titleController.text != previousWork.title) {
        modifiedData["title"] = titleController.text;
      }
      if (descriptionController.text != previousWork.description) {
        modifiedData["description"] = descriptionController.text;
      }
      if (modifiedData.isNotEmpty) {
        var error = await PortfolioService.editPreviousWork(
            modifiedData, previousWork.id);
        if (error) {
          snackBarModel("Failed", "Something went wrong", true);
        } else {
          final controller = Get.find<PortfolioController>();
          controller.updateWork(titleController.text, descriptionController.text);
          Get.back();
          snackBarModel("Success", "Previous work added", false);
        }
      }
      btnController.stop();
    } else {
      btnController.stop();
    }
  }

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController;

  late TextEditingController descriptionController;

  final validatorTitle = ValidationBuilder()
      .maxLength(30, "title is too long")
      .minLength(3, "title is too short")
      .build();
  final validatorDescription = ValidationBuilder()
      .maxLength(800, "description is too long")
      .minLength(10, "description is too short")
      .build();

  var numberCharDesc = "0/800".obs;

  changeDescription(String? value) {
    numberCharDesc.value =
        descriptionController.text.length.toString() + "/800";
  }

  Color longDescription() {
    return descriptionController.text.length > 800 ||
            descriptionController.text.length < 10
        ? Colors.redAccent
        : Colors.green;
  }
}
