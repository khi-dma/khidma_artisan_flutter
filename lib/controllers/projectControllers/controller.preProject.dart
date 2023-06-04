import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/snackBar.dart';
import 'package:khidma_artisan_flutter/constWidgets/widget.keyboard.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/models/model.step.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../data/fonc.data.dart';
import '../../services/service.project.dart';
import '../../views/Project/preProjet/components/component.datePick.dart';
import '../../views/dialogbox/dialog.addStep.dart';

class PreProjectController extends GetxController {

  var downloading = false.obs;
  var error = false.obs;
  ProjectModel project;
  late ProjectModel projectBefore;

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  RoundedLoadingButtonController btnSecondaryController =
      RoundedLoadingButtonController();

  PreProjectController({required this.project});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProject();
  }

  save() async {
    project.title = project.post.title;
    var error = await ProjectService.putProject(project);
    if (error) {
      snackBarModel("Failed", "Something went wrong", true);
    } else {
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
      Get.back();
      snackBarModel("Success", "Project lunched", false);
    }
    btnController.stop();
  }

  getProject() async {
    switchState();
    if(project.price==-1){
      var res = await ProjectService.getProject(project.id);
      error.value = res.error;
      project = res.data;
    }
    projectBefore = project.clone();
    initializeData();
    switchState();
  }

  initializeData() {
    if (project.startDate.isBefore(DateTime.now())) {
      updateStartDate(DateTime.now().add(const Duration(days: 2)));
    } else {
      startDate = dateToStringPreProject(project.startDate);
    }
    if (project.endDate.isBefore(project.startDate)) {
      updateEndDate(project.startDate.add(const Duration(days: 2)));
    } else {
      endDate = dateToStringPreProject(project.endDate);
    }
    stepsEnabled = project.steps.isNotEmpty;
  }

  String stepEndDate(int index) {
    DateTime date = project.startDate;
    for (int i = 0; i <= index; ++i) {
      date = date.add(Duration(days: project.steps[i].duration));
    }
    project.steps[index].endDate = date;

    return dateToStringPreProject(date);
  }

  deleteStep(int index) {
    project.steps.removeAt(index);
    if (project.steps.isEmpty) {
      stepsEnabled = false;
    }
    updateEndDateSteps();
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
          endDate: DateTime.now()));
      updateEndDateSteps();
      updatePriceEnablesSteps();
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
      updateEndDateSteps();
      updatePriceEnablesSteps();
    }
  }

  ///// dates
  late String startDate;
  late String endDate;

  ///// when change date
  updateDates(bool firstDate) {
    Get.bottomSheet(
      datePicker((date) {
        if (firstDate) {
          updateStartDate(date);
          if (stepsEnabled) {
            updateEndDateSteps();
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
              ? DateTime.now().add(const Duration(hours: 2))
              : project.startDate),
    );
  }

  updateStartDate(DateTime date) {
    project.startDate = date;
    startDate = dateToStringPreProject(date);
  }

  updateEndDate(DateTime date) {
    project.endDate = date;
    endDate = dateToStringPreProject(date);
  }

  void updateEndDateSteps() {
    DateTime date = project.startDate;
    for (int i = 0; i <= project.steps.length - 1; ++i) {
      date = date.add(Duration(days: project.steps[i].duration));
    }
    updateEndDate(date);
    update();
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
    update();
  }

  bool checked() {
    if (!project.checked) {
      return false;
    } else {
      return project == projectBefore;
    }
  }
}
