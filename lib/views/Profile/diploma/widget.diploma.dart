import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/errorWidget.dart';
import 'package:khidma_artisan_flutter/constWidgets/progressIndicator.dart';
import 'package:khidma_artisan_flutter/controllers/profileControllers/controller.diploma.dart';
import 'package:khidma_artisan_flutter/views/Profile/diploma/widget.emptyDiploma.dart';
import 'package:sizer/sizer.dart';

import 'components/component.diplomaWidgetModel.dart';

class DiplomaWidget extends StatelessWidget {
  const DiplomaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiplomaController());
    return SafeArea(
        child: Obx(
      () => Scaffold(
          appBar: appBarModel("Diploma"),
          body: controller.downloading.value
              ? circularProgressModel()
              : controller.error.value
                  ? errorWidget()
                  : controller.diplomas.isEmpty
                      ? emptyDiplomaWidget()
                      : GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          itemCount: controller.diplomas.length + 1,
                          itemBuilder: (ctx, index) {
                            return diplomaWidgetModel(index);
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.sp,
                            mainAxisSpacing: 10.sp,
                          ),
                        )),
    ));
  }
}
