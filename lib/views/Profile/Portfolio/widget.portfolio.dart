import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/constWidgets/errorWidget.dart';
import 'package:khidma_artisan_flutter/constWidgets/progressIndicator.dart';
import 'package:khidma_artisan_flutter/controllers/profileControllers/controller.portfolio.dart';
import 'package:khidma_artisan_flutter/views/Profile/Portfolio/widget.about.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'components/component.previousWorkWidgetModel.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PortfolioController());
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("Portfolio"),
      body: Obx(
        () => controller.downloading.value
            ? Center(child: circularProgressModel())
            : controller.error.value
                ? errorWidget()
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          about(),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Previous work :",
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            itemCount:
                                controller.portFolio.previousWork.length + 1,
                            itemBuilder: (ctx, index) {
                              return previousWorkWidgetModel(index);
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.sp,
                              mainAxisSpacing: 10.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
      ),
    ));
  }
}
