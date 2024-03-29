import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:sizer/sizer.dart';

import '../../constWidgets/emptyList.dart';
import '../../constWidgets/errorWidget.dart';
import '../../constWidgets/progressIndicator.dart';
import '../../controllers/Posts/controller.post.dart';
import '../Components/component.inputSearch.dart';
import 'components/component.postWidgetModel.dart';

class PostsWidget extends StatelessWidget {
  PostsWidget({Key? key}) : super(key: key);
  final controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    controller.getPosts();
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: InputSearchComponent(
              focusNode: controller.focusNode,
              hint: 'Search',
              submitted: controller.submit,
              textEditingController: controller.searchController,
            ),
          ),
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
                                            ? ThemeController.backgroundColor()
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
            ),
          )
        ],
      ),
    ));
  }
}
