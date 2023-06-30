import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/views/Home/widget.appBar.dart';
import 'package:sizer/sizer.dart';

import '../../constWidgets/emptyList.dart';
import '../../constWidgets/errorWidget.dart';
import '../../constWidgets/progressIndicator.dart';
import '../../controllers/Home/controller.home.dart';
import '../../controllers/Local/controller.theme.dart';
import '../../controllers/Posts/controller.post.dart';
import '../Posts/components/component.postWidgetModel.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.getPosts();

    return Column(
      children: [
        SizedBox(height: 2.h),
        appBarHome(),
        SizedBox(height: 1.5.h),
        Expanded(
            child: Stack(
              children: [
                Obx(
                  () => controller.downloading.value
                      ? circularProgressModel()
                      : controller.error.value
                          ? errorWidget()
                          : controller.posts.isEmpty
                              ? emptyListWarning()
                              : ListView.separated(
                                  controller: controller.scrollController,
                                  padding:
                                      EdgeInsets.only(top: 2.h, bottom: 12.h),
                                  itemBuilder: (context, index) => Hero(
                                      tag: "post$index",
                                      child:
                                          postWidgetModel(index, controller)),
                                  separatorBuilder: (context, index) =>
                                      Container(
                                        height: 2.h,
                                        color: ThemeController.isThemeDark()
                                            ? ThemeController
                                                .backgroundColor()
                                            : ThemeController
                                                .backScaffoldGroundColor(),
                                      ),
                                  itemCount: controller.posts.length),
                ),
                Visibility(
                  visible: ThemeController.isThemeDark(),
                  child: AnimatedContainer(
                    height: 3.h,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          ThemeController.backScaffoldGroundColor(),
                          Colors.transparent
                        ])),
                    duration: const Duration(milliseconds: 100),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
