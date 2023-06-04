import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/constWidgets/errorWidget.dart';
import 'package:khidma_artisan_flutter/constWidgets/progressIndicator.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/projectControllers/controller.preProject.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:khidma_artisan_flutter/views/Project/preProjet/widgets/widget.clientCard.dart';
import 'package:khidma_artisan_flutter/views/Project/preProjet/widgets/widget.projectDetails.dart';
import 'package:khidma_artisan_flutter/views/Project/preProjet/widgets/widget.steps.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class PreProjectWidget extends StatelessWidget {
  final ProjectModel project;

  const PreProjectWidget({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreProjectController(project: project));
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
                              projectDetails(),
                              SizedBox(
                                height: 2.h,
                              ),
                              const Divider(height: 0),
                              stepsWidget(),
                              const Divider(
                                height: 0,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              animatedButtonSecondary('Save draft',controller.save,controller.btnSecondaryController),
                              SizedBox(
                                height: 1.h,
                              ),
                              animatedButton(
                                  'Launch',
                                  controller.checked() ? controller.launch : null,
                                  controller.btnController),
                              SizedBox(
                                height: 1.h,
                              ),
                              Visibility(
                                visible: !(controller.project.checked),
                                child: Text(
                                  "You can launch it once the client checked it",
                                  style: TextStyle(
                                      color: ThemeController.secondaryColor()),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                  ),
      ),
    ));
  }
}
