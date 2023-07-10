import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Client/controller.client.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/Local/controller.theme.dart';
import '../../../../controllers/comments/controller.comments.dart';

Widget ratingBarWidgetModel(int stars) {
  final controller = Get.find<CommentsController>();
  bool selected = controller.selected.value == stars;
  final artisan = Get.find<ClientDetailController>().client;
  return InkWell(
    onTap: () => controller.updateSelected(stars),
    child: Card(
        color: selected
            ? ThemeController.greenColor()
            : ThemeController.backgroundColor(),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(
            children: [
              Text(stars.toString()),
              SizedBox(
                width: 2.w,
              ),
              Row(
                children: List.generate(
                  stars == 0 ? 1 : stars,
                  (index) {
                    return Icon(
                      Icons.star,
                      color: stars == 0 ? Colors.grey : Colors.yellow,
                    );
                  },
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text("( "+artisan.stars[stars].toString()+" )"),

            ],
          ),
        )),
  );
}
