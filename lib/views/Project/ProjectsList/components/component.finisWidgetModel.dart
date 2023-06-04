import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/projectControllers/controller.projectList.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:sizer/sizer.dart';

Widget finishedWidgetModel(int index){
  final controller = Get.find<ProjectListController>();
  ProjectModel project = controller.projectByIndex(index);
  return Container(height: 20,width: 20,color: Colors.red,);
}