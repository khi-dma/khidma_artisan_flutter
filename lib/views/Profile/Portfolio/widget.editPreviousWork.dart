
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import '../../../controllers/profile/controller.editPortfolio.dart';
import '../../Components/component.input.dart';
import 'package:sizer/sizer.dart';

class EditPreviousWorkWidget extends StatelessWidget {
  const EditPreviousWorkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditPortfolioController());
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("Edit previousWork"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
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
                animatedButton(
                    "Save", controller.editPortfolio, controller.btnController)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
