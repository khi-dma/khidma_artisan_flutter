import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.ProgressProject.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/views/Project/ProgressProject/widgets/widget.projectDetails.dart';
import 'package:khidma_artisan_flutter/views/Project/ProgressProject/widgets/widget.steps.dart';
import 'package:sizer/sizer.dart';

import '../../../constWidgets/errorWidget.dart';
import '../../../constWidgets/progressIndicator.dart';
import '../../Components/component.button.dart';
import '../components/widget.clientCard.dart';

class ProgressProjectWidget extends StatelessWidget {
  const ProgressProjectWidget({Key? key, required this.project,required this.from})
      : super(key: key);
  final ProjectModel project;
  final int from;

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(ProgressProjectController(project: project.clone(),from: from));
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
                          progressProjectDetails(),
                          Divider(height: 4.h),
                          stepsProgressProjectWidget(),
                          SizedBox(height: 2.h),
                          const Divider(
                            height: 0,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          GetBuilder(
                            init: controller,
                            id: "checkSteps",
                            builder: (context) {
                              return animatedButton(
                                  'Save',
                                  controller.enableButton() ? controller.save : null,
                                  controller.btnController);
                            }
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    ));
  }
}
