import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Posts/controller.request.dart';
import 'package:khidma_artisan_flutter/models/model.post.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:khidma_artisan_flutter/views/Components/component.input.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/Local/controller.theme.dart';
import '../../data/const.data.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({Key? key, required this.post,required this.function}) : super(key: key);
  final PostModel post;
  final RequestCallback function;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestController(post: post,function: function));
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        color: ThemeController.backScaffoldGroundColor(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.sp),
                topRight: Radius.circular(12.sp))),
        child: Padding(
          padding: EdgeInsets.symmetric( horizontal: 3.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 3.h),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/icons/rectButtomSheet.svg",
                  ),
                ),
                SizedBox(height: 3.h),
                InputComponent(
                  textEditingController: controller.requestController,
                  hintText:
                      'please provide the important information such the time , price , if u have already worked the same work ... ',
                  label: 'description',
                  validate: controller.requestValidate,
                  change: controller.changeRequest,
                  maxLines: 7,
                ),
                SizedBox(height: 1.h),
                GetBuilder(
                  init: controller,
                  builder: (context) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          controller.numberCharDesc.value,
                          style: TextStyle(color: controller.longDescription()),
                        ),
                      );
                  }
                ),
                SizedBox(
                  height: 3.h,
                ),
                animatedButton(
                    "request", controller.request, controller.btnController),
                SizedBox(height: 2.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
