import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/services/service.project.dart';
import 'package:khidma_artisan_flutter/views/Project/ProgressProject/widget.progressProject.dart';
import 'package:khidma_artisan_flutter/views/Project/preProjet/widget.preProject.dart';

import '../../data/fonc.data.dart';
import '../../views/Project/FinishedProject/widget.finishedProject.dart';

class ProjectListController extends GetxController {
  List<ProjectModel> allProjects = [];
  Map<int, List<ProjectModel>> projects = {0: [], 1: [], 2: [], 3: [] };
  var error = false.obs;

  getProjects() async {
    switchState();
    var res = await ProjectService.getProjects();
    print(res.data);
    error.value = res.error;
    allProjects = res.data;
    splitLists();
    switchState();
  }

  splitLists() {
    projects = {0: [], 1: [], 3: [], 2: []};
    for (var project in allProjects) {
      projects[project.state]!.add(project);
    }
  }

  //// UI
  var selected = 1.obs;

  updateSelected(int whichOne) {
    selected.value = whichOne;
    getProjects();
  }

  List<ProjectModel> currentProjects() {
    return projects[selected.value] ?? [];
  }

  Rx<bool> downloading = false.obs;

  switchState() {
    downloading.value = !downloading.value;
  }

  ProjectModel projectByIndex(int index) {
    return projects[selected.value]![index];
  }

  double percentProgress(ProjectModel project) {
    return percent(project.steps.where((element) => element.checked).length,
        project.steps.length);
  }

  //// selected index
  int selectedProjectIndex = 0;




  replace(ProjectModel project, int whichOne){
    projects[whichOne]!.removeAt(selectedProjectIndex);
    projects[whichOne]!.insert(selectedProjectIndex, project);
    update(["list"]);
  }

  //// which one , 0 from define to next
  move(ProjectModel project,int whichOne){
    if(whichOne==0){
      projects[0]!.removeAt(selectedProjectIndex);
      projects[1]!.insert(0, project);
      selected.value=1;
    }else if(whichOne==1){
      projects[1]!.removeAt(selectedProjectIndex);
      projects[0]!.insert(0, project);
      selected.value=0;
    }
    update(["list"]);

  }

  toProgress(int index,ProjectModel project){
    selectedProjectIndex = index;
    Get.to(()=>ProgressProjectWidget(project: project,from: 1,));
  }

  toDefine(int index,ProjectModel project){
    selectedProjectIndex = index;
    Get.to(()=>PreProjectWidget(project: project, from: 1,));
  }
  toFinish(int index, ProjectModel project) {
    selectedProjectIndex = index;
    Get.to(() => FinishedProjectWidget(project: project.clone(), from: 1));
  }


}
