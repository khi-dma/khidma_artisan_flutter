import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/snackBar.dart';
import 'package:khidma_artisan_flutter/constWidgets/widget.keyboard.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.projectList.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/models/model.step.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../services/service.project.dart';
import '../../views/Project/preProjet/components/component.datePick.dart';
import '../../views/dialogbox/dialog.addStep.dart';

class PreProjectController extends GetxController {
  var downloading = false.obs;
  var error = false.obs;

  //// 0 chat , 1 project list
  int from;
  ProjectModel project;
  late ProjectModel projectBefore;

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  RoundedLoadingButtonController btnSecondaryController =
      RoundedLoadingButtonController();

  PreProjectController({required this.project, required this.from});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
      getProject();

  }

  save() async {
    project.title = project.post.title;
    if (!stepsEnabled) {
      project.steps.clear();
    }
    var error = await ProjectService.putProject(project);
    if (error) {
      snackBarModel("Failed", "Something went wrong", true);
    } else {
      if (from == 1) {
        project.checked = false;
        final controller = Get.find<ProjectListController>();
        //// check if the project was in the list of next or define to know if to move it or replace it
        if (projectBefore.state == 1) {
          project.state = 0;
          controller.move(project, 1);
        } else {
          controller.replace(project, 0);
        }
      }
      Get.back();
      snackBarModel("Success", "Drafts saved", false);
    }
    btnSecondaryController.stop();
  }

  launch() async {
    var error = await ProjectService.launchProject(project);
    if (error) {
      snackBarModel("Failed", "Something went wrong", true);
    } else {
      project.state = 1;
      if (from == 1) {
        final controller = Get.find<ProjectListController>();
        controller.move(project, 0);
      }
      Get.back();
      snackBarModel("Success", "Project lunched", false);
    }
    btnController.stop();
  }

  getProject() async {
    switchState();

    if(from!=0){
      var res = await ProjectService.getProject(project.id);
      error.value = res.error;
      project = res.data;
    }
    initializeData();
    projectBefore = project.clone();
    switchState();
  }

  initializeData() {
    if (project.startDate.isBefore(DateTime.now())) {
      updateStartDate(DateTime.now().add(const Duration(days: 2)));
    }
    if (project.endDate.isBefore(project.startDate)) {
      updateEndDate(project.startDate.add(const Duration(days: 2)));
    }
    stepsEnabled = project.steps.isNotEmpty;
  }

  updateStepEndDate() {
    DateTime date = project.startDate;
    for (int i = 0; i < project.steps.length; ++i) {
      date = date.add(Duration(days: project.steps[i].duration));
      project.steps[i].endDate = date;
    }
    project.endDate = project.steps.last.endDate;
    update();
  }

  deleteStep(int index) {
    project.steps.removeAt(index);
    if (project.steps.isEmpty) {
      stepsEnabled = false;
    }
    updateStepEndDate();
    updatePriceEnablesSteps();
    update();
  }

  ////Add step
  TextEditingController titleController = TextEditingController();
  final validatorTitle =
      ValidationBuilder().minLength(3, "too short").required().build();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String price = "1";
  int duration = 1;

  addStep() {
    if (formKey.currentState!.validate()) {
      project.steps.add(StepModel(
          id: -1,
          title: titleController.text,
          duration: duration,
          price: int.parse(price),
          endDate: DateTime.now(),
          checkDemand: false,
          checked: false,
          late: false));
      updatePriceEnablesSteps();
      updateStepEndDate();
      titleController.clear();
      price = "1";
      duration = 1;
      update();
      Get.back();
    }
  }

  updatePriceStep() {
    Get.to(() => KeyboardWidget(price, (String newValue) {
          price = newValue;
          update();
        }));
  }

  updateDurationStep() {
    Get.to(() => KeyboardWidget(duration.toString(), (String newValue) {
          duration = int.parse(newValue);
          update();
        }));
  }

  ///// price
  updatePrice() {
    Get.to(() => KeyboardWidget(project.price.toString(), (String newValue) {
          project.price = int.parse(newValue);
          update();
        }));
  }

  updatePriceEnablesSteps() {
    int price = project.price;
    if (project.steps.isNotEmpty) {
      price = 0;
      for (int i = 0; i < project.steps.length; ++i) {
        price += project.steps[i].price;
      }
      project.price = price;
    }
    update();
  }

  //// enable steps
  bool stepsEnabled = false;

  //// switch steps enable
  updateStepEnabled(value) async {
    stepsEnabled = value;
    update();
    if (value && project.steps.isEmpty) {
      await Get.dialog(dialogAddStep());
      if (project.steps.isEmpty) {
        stepsEnabled = false;
        update();
      }
    }
    if (value && project.steps.isNotEmpty) {
      updateStepEndDate();
      updatePriceEnablesSteps();
    }
  }



  ///// when change date
  updateDates(bool firstDate) {
    Get.bottomSheet(
      datePicker((date) {
        if (firstDate) {
          updateStartDate(date);
          if (stepsEnabled) {
            updateStepEndDate();
          } else if (date.isAfter(project.endDate)) {
            updateEndDate(date.add(const Duration(days: 2)));
          }
        } else {
          updateEndDate(date);
        }
        update();
      },
          firstDate ? project.startDate : project.endDate,
          firstDate
              ? DateTime.now().add(const Duration(hours: 1))
              : project.startDate),
    );
  }

  updateStartDate(DateTime date) {
    project.startDate = date;
  }

  updateEndDate(DateTime date) {
    project.endDate = date;
  }

  /////UI
  switchState() {
    downloading.value = !downloading.value;
  }

  void onChangeOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    project.steps.insert(newIndex, project.steps.removeAt(oldIndex));
    updateStepEndDate();
  }

  //// to know how to show button
  bool enableLaunchButton() {
    if (!project.checked) {
      return false;
    } else {
      return project == projectBefore  && stepsEnabled == projectBefore.steps.isNotEmpty;
    }
  }

  bool enableSaveButton() {
    return project != projectBefore || stepsEnabled == projectBefore.steps.isEmpty;
  }
}
