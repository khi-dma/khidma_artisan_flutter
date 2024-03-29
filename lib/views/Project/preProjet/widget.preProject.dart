import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/constWidgets/errorWidget.dart';
import 'package:khidma_artisan_flutter/constWidgets/progressIndicator.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.preProject.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:khidma_artisan_flutter/views/Project/components/widget.clientCard.dart';
import 'package:khidma_artisan_flutter/views/Project/preProjet/widgets/widget.projectDetails.dart';
import 'package:khidma_artisan_flutter/views/Project/preProjet/widgets/widget.steps.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class PreProjectWidget extends StatelessWidget {
  final ProjectModel project;
  final int from;

  ////0 chat , 1 project list

  const PreProjectWidget({Key? key, required this.project, required this.from})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(PreProjectController(project: project.clone(), from: from));
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarModel("Project"),
      body: Obx(
        () => controller.downloading.isTrue
            ? circularProgressModel()
            : controller.error.isTrue
                ? errorWidget()
                : SingleChildScrollView(
                    child: GetBuilder(
                        init: controller,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Column(
                              children: [
                                clientCard(controller.project.client),
                                SizedBox(height: 2.h),
                                artisanCard(controller.project.artisan),
                                Divider(height: 6.h),
                                preProjectDetails(),
                                SizedBox(
                                  height: 2.h,
                                ),
                                const Divider(height: 0),
                                stepsPreProjectWidget(),
                                const Divider(
                                  height: 0,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                animatedButtonSecondary(
                                    'Send to check',
                                    controller.enableSaveButton()
                                        ? controller.save
                                        : null,
                                    controller.btnSecondaryController),
                                SizedBox(
                                  height: 2.h,
                                ),
                                ///// not showing it when project is already launched
                                Visibility(
                                  visible: controller.project.state != 1,
                                  child: animatedButton(
                                      'Launch',
                                      controller.enableLaunchButton()
                                          ? controller.launch
                                          : null,
                                      controller.btnController),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Visibility(
                                  visible: !(controller.project.checked),
                                  child: Text(
                                    "You can launch it once the client checked it",
                                    style: TextStyle(
                                        color:
                                            ThemeController.secondaryColor()),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
      ),
    ));
  }
}
