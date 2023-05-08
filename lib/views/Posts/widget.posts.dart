import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constWidgets/emptyList.dart';
import '../../constWidgets/errorWidget.dart';
import '../../constWidgets/progressIndicator.dart';
import '../../controllers/PostsControllers/controller.post.dart';
import 'components/component.postWidgetModel.dart';

class PostsWidget extends StatelessWidget {
  PostsWidget({Key? key}) : super(key: key);
  final controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    controller.getPosts();
    return Column(
      children: [
        SizedBox(
          height: 2.h,
        ),
        Expanded(
          child: Obx(
            () => controller.downloading.value
                ? circularProgressModel()
                : controller.error.value
                    ? errorWidget()
                    : controller.posts.isEmpty
                        ? emptyListWarning()
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            itemBuilder: (context, index) => InkWell(
                                onTap: () => controller.toRequest(index),
                                child: Hero(tag: "post$index",
                                child: postWidgetModel(index,true))),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 2.h,
                                ),
                            itemCount: controller.posts.length),
          ),
        )
      ],
    );
  }
}
