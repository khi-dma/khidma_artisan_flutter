import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/models/model.step.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constWidgets/snackBar.dart';
import '../../services/service.project.dart';
import 'controller.projectList.dart';

class ProgressProjectController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProject();
  }

  int from;
  late ProjectModel projectBefore;
  ProjectModel project;

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  ProgressProjectController({required this.project, required this.from});

  getProject() async {
    switchState();
    if (from == 1) {
      var res = await ProjectService.getProject(project.id);
      error.value = res.error;
      project = res.data;
    }
    projectBefore = project.clone();
    switchState();
  }

  save() async {
    List<int> idSteps = [
      for (int i = 0; i < project.steps.length; ++i)
        if (project.steps[i].checkDemand != projectBefore.steps[i].checkDemand)
          project.steps[i].id
    ];
    btnController.stop();
    var error = await ProjectService.checkDemand(idSteps, project.id);
    if (error) {
      snackBarModel("Failed", "Something went wrong", true);
    } else {
      if (from == 1) {
        final controller = Get.find<ProjectListController>();
        controller.replace(project, 2);
      }
      Get.back();
      snackBarModel("Success", "Drafts saved", false);
    }
  }

  /////UI
  var downloading = false.obs;
  var error = false.obs;

  switchState() {
    downloading.value = !downloading.value;
  }

  ///// update check
  updateChecked(bool? newValue, StepModel step) {
    step.checkDemand = newValue ?? false;
    update(["checkSteps"]);
  }

  ///// to show button
  bool enableButton() {
    bool enable = false;
    for (int i = 0; i < project.steps.length; i++) {
      if (project.steps[i].checkDemand != projectBefore.steps[i].checkDemand) {
        enable = true;
        break;
      }
    }
    return enable;
  }
}
