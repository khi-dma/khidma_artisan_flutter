import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../constWidgets/appBar.dart';
import '../../../constWidgets/cashedNetwork.dart';
import '../../../constWidgets/errorWidget.dart';
import '../../../constWidgets/progressIndicator.dart';
import '../../../controllers/Local/controller.theme.dart';
import '../../../controllers/comments/controller.addComment.dart';
import '../../../models/model.project.dart';
import '../../Components/component.button.dart';
import '../../Components/component.input.dart';

class AddCommentWidget extends StatelessWidget {
  const AddCommentWidget({required this.project, Key? key}) : super(key: key);
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddCommentController(project: project));
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("Comment"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Obx(
          () => controller.downloading.isTrue
              ? circularProgressModel()
              : controller.error.isTrue
                  ? errorWidget()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70.sp,
                            width: 70.sp,
                            child: ClipOval(
                              child: cachedNetworkModel(
                                  project.client.profilePicture),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            project.client.name,
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          LottieBuilder.asset(
                            "assets/animations/292-5-stars.json",
                            height: 40.sp,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Card(
                            child: Padding(
                              padding:  EdgeInsets.all(5.sp),
                              child: RatingBar.builder(
                                minRating: 0,
                                itemSize: 33.sp,
                                initialRating: 0,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                onRatingUpdate: (value) => controller
                                    .rating = value.truncate(),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star_rounded,
                                  color: ThemeController.greenSecondColor(),
                                  size: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          InputComponent(
                            textEditingController: controller.commentController,
                            hintText: "Comment",
                            maxLines: 5,
                            validate: (value) {},
                            labelShow: false,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          animatedButton(
                              'Send', controller.rate, controller.btnController)
                        ],
                      ),
                    ),
        ),
      ),
    ));
  }
}
