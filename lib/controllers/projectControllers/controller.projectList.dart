import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/services/service.project.dart';

class ProjectListController extends GetxController {
  List<ProjectModel> allProjects = [];
  Map<int, List<ProjectModel>> projects = {0: [], 1: [],3:[], 2: []};
  var error = false.obs;

  getProjects() async {
    switchState();
    var res = await ProjectService.getProjects();
    error.value = res.error;
    allProjects = res.data;
    splitLists();
    switchState();
  }

  splitLists() {
    projects = {0: [], 1: [],3:[], 2: []};
    for(var project in allProjects){
      if(project.state!=1){
        projects[project.state]!.add(project);
      }else{
        if(project.startDate.isAfter(DateTime.now())){
          projects[3]!.add(project);
        }else{
          projects[1]!.add(project);
        }
      }
    }
  }

  //// UI
  var selected = 0.obs;

  updateSelected(int whichOne){
    selected.value = whichOne;
  }
  List<ProjectModel> currentProjects() {
    return projects[selected.value] ??[];
  }

  Rx<bool> downloading = false.obs;
  switchState(){
    downloading.value = !downloading.value;
  }

  ProjectModel projectByIndex(int index) {
    return projects[selected.value]![index];
  }


}
