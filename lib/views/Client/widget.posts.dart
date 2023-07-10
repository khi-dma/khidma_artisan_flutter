import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/emptyList.dart';
import 'package:khidma_artisan_flutter/constWidgets/progressIndicator.dart';
import 'package:khidma_artisan_flutter/controllers/Client/controller.client.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'component.postWidgetModel.dart';

class PostsClientWidget extends StatelessWidget {
  const PostsClientWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientDetailController>();
    return controller.downloadingPosts.isTrue
        ? circularProgressModel()
        : controller.posts.isEmpty
            ? emptyListWarning()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.posts.length,
                itemBuilder: (context, index) =>
                    postWidgetModelClient(index, controller));
  }
}
