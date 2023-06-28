import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/controllers/profile/controller.addPortfolio.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import '../../../constWidgets/addPic.dart';
import '../../Components/component.input.dart';
import 'package:sizer/sizer.dart';

class AddPreviousWorkWidget extends StatelessWidget {
  const AddPreviousWorkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddPortfolioController());
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("Add previousWork"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: InkWell(
                      onTap: () => controller.takePick(),
                      child: controller.picPath.value.isEmpty
                          ? addPicModel()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(5.sp),
                              child: Image.file(
                                File(controller.picPath.value),
                                height: 80.sp,
                                width: 80.sp,
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                InputComponent(
                  textEditingController: controller.titleController,
                  hintText: 'Title',
                  validate: controller.validatorTitle,
                ),
                SizedBox(height: 2.h),
                InputComponent(
                  textEditingController: controller.descriptionController,
                  hintText: 'description',
                  validate: controller.validatorDescription,
                  maxLines: 8,
                  change: controller.changeDescription,
                ),
                SizedBox(height: 1.h),
                Obx(
                  () => Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      controller.numberCharDesc.value,
                      style: TextStyle(color: controller.longDescription()),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                animatedButton("Add", controller.addPortfolio, controller.btnController)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
