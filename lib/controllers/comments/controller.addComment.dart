import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../models/model.project.dart';
import '../cryptoMoney/controller.rating.dart';

class AddCommentController extends GetxController {
  ProjectModel project;
  var downloading = false.obs;
  var error = false.obs;
  int rating = 0;
  TextEditingController commentController = TextEditingController();
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  AddCommentController({required this.project});

  switchState() => downloading.value = !downloading.value;

  void rate() async {
    final controller = Get.put(RatingCryptoController(
        project: project,
        comment: commentController.text,
        rating: rating.truncate()));
    await controller.rate();
    btnController.stop();
  }
}
