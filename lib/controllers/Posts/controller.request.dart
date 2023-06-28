
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constWidgets/snackBar.dart';
import '../../data/const.data.dart';
import '../../models/model.chat.dart';
import '../../models/model.request.dart';
import '../../services/service.post.dart';
import '../../views/Chat/widget.messages.dart';
import '../Chat/controller.message.dart';

class RequestController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();
  PostModel post;
  RequestCallback function;

  RequestController({required this.post,required this.function});


  TextEditingController requestController = TextEditingController();
  StringValidationCallback requestValidate = ValidationBuilder()
      .minLength(100, 'too short')
      .maxLength(700, 'too long')
      .build();

  var numberCharDesc = "0/100".obs;

  changeRequest(String? p1) {
    numberCharDesc.value = requestController.text.length.toString() + "/100";
    update();
  }

  Color longDescription() {
    return requestController.text.length < 100 ||
        requestController.text.length > 700
        ? Colors.redAccent
        : Colors.green;
  }

  request() async {
    if (formKey.currentState!.validate()) {
     var res = await PostService.request(RequestModel(
          idRequest: -1,
          idPost: post.idPost,
          description: requestController.text,
          uidChat: '',
          idArtisan: -1));
      if (res.error) {
        Get.back();
        snackBarModel("failed", "Something went wrong", true);
      } else {
        Get.back();
        snackBarModel("Success", "Request sent", false);
        function(res.data);
      }

    }
    btnController.stop();


  }
}