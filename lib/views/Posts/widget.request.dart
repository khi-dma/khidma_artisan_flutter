import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/PostsControllers/controller.post.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:khidma_artisan_flutter/views/Components/component.input.dart';
import 'package:sizer/sizer.dart';

import 'components/component.postWidgetModel.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostController>();
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("request".tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Hero(tag: "post${controller.currentPostRequest}",
                child: postWidgetModel(controller.currentPostRequest,false)),
                SizedBox(
                  height: 2.h,
                ),
                InputComponent(
                  textEditingController: controller.requestController,
                  hintText:
                      'please provide the important information such the time , price , if u have already worked the same work ... ',
                  label: 'description',
                  validate: controller.requestValidate,
                  change: controller.changeRequest,
                  maxLines: 9,
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
                SizedBox(height: 3.h,),
                animatedButton("request", controller.request, controller.btnController)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
