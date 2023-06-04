import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/projectControllers/controller.preProject.dart';
import 'package:khidma_artisan_flutter/models/model.step.dart';
import 'package:sizer/sizer.dart';

Widget stepWidgetModel(int index) {
  final controller = Get.find<PreProjectController>();
  StepModel step = controller.project.steps[index];
  return Slidable(
    key: Key('$index'),
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (BuildContext context) {
            controller.deleteStep(index);
          },
          backgroundColor: Colors.transparent,
          foregroundColor: ThemeController.primaryColor(),
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
    child: Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.sp),
          side:
              BorderSide(color: ThemeController.tertiaryColor(), width: 1.sp)),
      child: ListTile(
        title: Text(
          step.title,
          style: TextStyle(fontSize: 13.sp),
        ),
        subtitle: Text("Ends in "+controller.stepEndDate(index),
            style: TextStyle(
                fontSize: 11.sp, color: ThemeController.secondaryColor())),
        trailing: Text(step.price.toString() + " " + "DA"),
      ),
    ),
  );
}
