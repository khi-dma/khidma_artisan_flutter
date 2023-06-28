
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/cashedNetwork.dart';
import 'package:khidma_artisan_flutter/controllers/profile/controller.diploma.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/Local/controller.theme.dart';


class DetailDiplomaWidget extends StatelessWidget {
   DetailDiplomaWidget({required this.index,Key? key}) : super(key: key);
  final int index ;
  final controller = Get.find<DiplomaController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          width: 90.w,
          decoration: BoxDecoration(
              color: ThemeController.backScaffoldGroundColor(),
              borderRadius: BorderRadius.circular(7.sp)),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints)  {
              print(constraints.maxHeight);
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.sp),
                        child: cachedNetworkModel(controller.diplomas[index].url),
                      ),
                      Visibility(
                        visible: controller.diplomas[index].state == 2,
                        child: Container(
                            width: 90.w,
                            height:constraints.maxHeight*0.30,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.black, Colors.transparent]))),
                      ),
                      Card(
                        color: Colors.transparent,
                        child: Visibility(
                            visible: controller.diplomas[index].state == 2,
                            child: Text(
                              controller.diplomas[index].cause,
                              style: TextStyle(fontSize: 13.sp),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  button("Delete", () => controller.delete(index), Colors.red)
                ],
              );
            }
          )),
    );
  }
}
