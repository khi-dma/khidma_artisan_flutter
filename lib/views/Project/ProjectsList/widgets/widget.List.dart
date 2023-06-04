import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/emptyList.dart';
import 'package:khidma_artisan_flutter/constWidgets/errorWidget.dart';
import 'package:khidma_artisan_flutter/constWidgets/progressIndicator.dart';
import 'package:khidma_artisan_flutter/controllers/projectControllers/controller.projectList.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/views/Project/ProjectsList/widgets/widget.itemBuilderList.dart';
import 'package:sizer/sizer.dart';

Widget projectsListModel() {
  final controller = Get.find<ProjectListController>();
  return Obx(() {
    List<ProjectModel> projects =
        controller.projects[controller.selected.value] ?? [];
    return Expanded(
      child: controller.downloading.value
          ? circularProgressModel()
          : controller.error.value
              ? errorWidget()
              : projects.isEmpty
                  ? emptyListWarning()
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      itemCount: projects.length,
                      itemBuilder: (context, index) => itemBuilderList(index)),
    );
  });
}
