import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../models/model.project.dart';
import '../../services/service.project.dart';

class FinishedProjectController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProject();
  }

  int from;
  ProjectModel project;
  RoundedLoadingButtonController btnController=RoundedLoadingButtonController();
  FinishedProjectController({required this.project,required this.from});

  getProject() async {
    if(from==1){
      switchState();
      var res = await ProjectService.getProject(project.id);
      error.value = res.error;
      project = res.data;
      switchState();
    }
  }


  /////UI
  var downloading = false.obs;
  var error = false.obs;
  switchState() {
    downloading.value = !downloading.value;
  }

}