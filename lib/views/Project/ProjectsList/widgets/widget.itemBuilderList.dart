import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/projectControllers/controller.projectList.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/views/Project/ProjectsList/components/component.defineWidgetModel.dart';
import 'package:khidma_artisan_flutter/views/Project/ProjectsList/components/component.finisWidgetModel.dart';
import 'package:khidma_artisan_flutter/views/Project/ProjectsList/components/component.nextWidgetModel.dart';
import 'package:sizer/sizer.dart';

import '../components/component.progressWidgetModel.dart';

Widget itemBuilderList(int index){
  final controller = Get.find<ProjectListController>();
  switch(controller.selected.value){
    case(0):{
      return defineWidgetModel(index);
    }
    case(1):{
      return progressWidgetModel(index);
    }
    case(3):{
      return nextWidgetModel(index);
    }
    case(2):{
      return finishedWidgetModel(index);
    }
    default:{
      return defineWidgetModel(index);
    }
  }
}