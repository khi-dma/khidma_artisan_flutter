import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constWidgets/appBar.dart';
import '../../../constWidgets/emptyList.dart';
import '../../../constWidgets/errorWidget.dart';
import '../../../constWidgets/progressIndicator.dart';
import '../../../controllers/comments/controller.comments.dart';
import 'components/component.ListRatingBarModel.dart';
import 'components/component.ratingModel.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({required this.id, Key? key}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommentsController(idArtisan: id));
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("Comments"),
      body: Column(
        children: [
          SizedBox(
            height: 7.h,
            child: Obx(
              () => ListView(
                scrollDirection: Axis.horizontal,
                children: [5, 4, 3, 2, 1, 0]
                    .map((e) => ratingBarWidgetModel(e))
                    .toList(),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: Obx(
              () => controller.downloading.isTrue
                  ? circularProgressModel()
                  : controller.error.isTrue
                      ? errorWidget()
                      : controller.comments.isEmpty
                          ? emptyListWarning()
                          : ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              itemCount: controller.comments.length,
                              itemBuilder: (context, index) =>
                                  ratingModelWidget(controller.comments[index]),
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 2.h,
                              ),
                            ),
            ),
          ),
        ],
      ),
    ));
  }
}
