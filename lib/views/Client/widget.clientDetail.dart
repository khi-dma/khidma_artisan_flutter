import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/constWidgets/errorWidget.dart';
import 'package:khidma_artisan_flutter/constWidgets/progressIndicator.dart';
import 'package:khidma_artisan_flutter/controllers/Client/controller.client.dart';
import 'package:khidma_artisan_flutter/models/model.client.dart';
import 'package:khidma_artisan_flutter/views/Client/widget.personalInformation.dart';
import 'package:khidma_artisan_flutter/views/Client/widget.posts.dart';
import 'package:khidma_artisan_flutter/views/Client/widget.ratingWidget.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

import '../Comments/Comments/widget.comments.dart';

class ClientDetailWidget extends StatelessWidget {
  const ClientDetailWidget({required this.client, Key? key}) : super(key: key);
  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientDetailController(client: client));
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("Client"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: SingleChildScrollView(
          child: Obx(
            () => controller.downloadingPosts.isTrue
                ? circularProgressModel()
                : controller.error.isTrue
                    ? errorWidget()
                    : Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          personalInformationClient(),
                          SizedBox(
                            height: 3.h,
                          ),
                          ratingWidget(controller.client),
                          TextButton(
                              onPressed: () => Get.to(() => CommentsWidget(
                                    id: controller.client.phoneNumber.toString(),
                                  )),
                              child: const Text("See comments")),
                          SizedBox(
                            height: 1.h,
                          ),
                          const PostsClientWidget()
                        ],
                      ),
          ),
        ),
      ),
    ));
  }
}
