import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.projectList.dart';
import 'package:khidma_artisan_flutter/views/Project/ProjectsList/widgets/widget.List.dart';
import 'package:khidma_artisan_flutter/views/Project/ProjectsList/widgets/widget.toggleSwitch.dart';
import 'package:sizer/sizer.dart';

class ProjectListWidget extends StatelessWidget {
  const ProjectListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectListController());
    controller.getProjects();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        children: [
          toggleSwitch(),
          SizedBox(height: 2.h),
          projectsListModel()


        ],
      ),
    );
  }
}
