import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/views/Project/FinishedProject/widgets/widget.projectDetails.dart';
import 'package:khidma_artisan_flutter/views/Project/FinishedProject/widgets/widget.steps.dart';
import 'package:sizer/sizer.dart';

import '../../../constWidgets/appBar.dart';
import '../../../constWidgets/errorWidget.dart';
import '../../../constWidgets/progressIndicator.dart';
import '../../../controllers/project/controller.finishedProject.dart';
import '../../../models/model.project.dart';
import '../../Components/component.button.dart';
import '../components/widget.clientCard.dart';

class FinishedProjectWidget extends StatelessWidget {
  const FinishedProjectWidget({Key? key, required this.project,required this.from})
      : super(key: key);
  final ProjectModel project;
  final int from;


  @override
  Widget build(BuildContext context) {
    final controller =
    Get.put(FinishedProjectController(project: project,from: from));
    return SafeArea(
        child: Scaffold(
          appBar: appBarModel(project.title),
          body: Obx(
                ()=> controller.downloading.isTrue
                ? circularProgressModel()
                : controller.error.isTrue
                ? errorWidget()
                : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    clientCard(controller.project.client),
                    SizedBox(height: 2.h),
                    artisanCard(controller.project.artisan),
                    Divider(height: 6.h),
                    finishedProjectDetails(),
                    Divider(height: 4.h),
                    stepsFinishedProjectWidget(),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
