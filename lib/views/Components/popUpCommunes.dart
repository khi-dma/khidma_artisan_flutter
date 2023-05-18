import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/LocalController/controller.theme.dart';
import '../../controllers/authControllers/controller.signUp.dart';
import '../../data/font.data.dart';


showCommunes(BuildContext context) {
  final controller = Get.find<SignUpController>();
  showDialog(
      context: context,
      builder: (_) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          backgroundColor: ThemeController.backScaffoldGroundColor(),
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60.h,
                width: 80.w,
                child: ListView.builder(
                    itemCount: controller.currentCommune().length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: ()=> controller.chooseCommune(index),
                          child:communeWidgetModel(controller.currentCommune()[index]));
                    }),
              )
            ],
          ),
        );
      }));
}

Widget communeWidgetModel(String city) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.sp)),
    child: ListTile(
      title: Text(
        city,
        style: TextStyle(fontWeight: regular, fontSize: 12.sp),
      ),
    ),
  );
}
