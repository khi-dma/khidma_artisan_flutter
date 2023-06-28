import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Posts/controller.save.dart';
import 'package:sizer/sizer.dart';
import '../../../constWidgets/emptyList.dart';
import '../../Posts/components/component.postWidgetModel.dart';

class SavedPostWidget extends StatelessWidget {
  const SavedPostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller  = Get.put(SaveController());
    return SafeArea(child: Scaffold(
      appBar: appBarModel("Saved post"),
      body: controller.posts.isEmpty
          ? emptyListWarning()
          : ListView.separated(
          padding: EdgeInsets.only(top: 2.h, bottom: 12.h),
          itemBuilder: (context, index) => Hero(
              tag: "post$index",
              child: postWidgetModel(index,controller)),
          separatorBuilder: (context, index) => SizedBox(
            height: 2.h,
          ),
          itemCount: controller.posts.length),
    ));
  }
}
