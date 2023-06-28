import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.preProject.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:khidma_artisan_flutter/views/Project/preProjet/components/component.rowModel.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/Local/controller.theme.dart';
import '../Components/component.input.dart';

Widget dialogAddStep() {
  final controller = Get.find<PreProjectController>();
  return Center(
    child: GetBuilder(
      init: controller,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          width: 80.w,
          decoration: BoxDecoration(
              color: ThemeController.backScaffoldGroundColor(),
              borderRadius: BorderRadius.circular(7.sp)),
          child: Card(
            color: ThemeController.backScaffoldGroundColor(),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputComponent(
                    validate: controller.validatorTitle,
                    hintText: 'Title',
                    textEditingController: controller.titleController,
                  ),
                  SizedBox(height: 2.h),
                  rowModel("PRICE",controller.price+" DA",controller.updatePriceStep ),
                  SizedBox(height: 2.h),
                  rowModel("DURATION",controller.duration.toString()+" Days",controller.updateDurationStep ),
                  SizedBox(height: 2.h),
                  button("Add step", controller.addStep)

                ],
              ),
            ),
          ),
        );
      }
    ),
  );
}
