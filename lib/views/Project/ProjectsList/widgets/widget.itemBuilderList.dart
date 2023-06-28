import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.projectList.dart';
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
      return nextWidgetModel(index);
    }
    case(3):{
      return finishedWidgetModel(index);
    }
    case(2):{
      return progressWidgetModel(index);
    }
    default:{
      return defineWidgetModel(index);
    }
  }
}