import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/profileControllers/controller.portfolio.dart';
import 'package:khidma_artisan_flutter/views/Profile/Portfolio/widget.editPreviousWork.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../constWidgets/cashedNetwork.dart';
import '../../dialogbox/dialog.delete.dart';

class PreviousWorkDetail extends StatelessWidget {
  const PreviousWorkDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    return SafeArea(
        child: Scaffold(
      body: Obx(
        () => InkWell(
          onTap: () => controller.switchShow(),
          child: Stack(
            children: [
              Center(
                child: Hero(
                  tag: "PWork${controller.currentIndex}",
                  child: cachedNetworkModel(controller.currentWork.value.urlPic),
                ),
              ),
              Visibility(
                visible: controller.showDetails.value,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])),
                ),
              ),
              Visibility(
                visible: controller.showDetails.value,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 95.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appBarModel("work detail"),
                        const Spacer(),
                        Text(
                          controller.currentWork.value.title,
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(controller.currentWork.value.description),
                        SizedBox(
                          height: 4.h,
                        ),
                        const Divider(
                          indent: 0,
                          endIndent: 0,
                          color: Colors.white,
                          height: 0,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      Get.dialog(dialogBoxDelete(controller.deletePWork)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.delete_outlined),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        'delete',
                                        style: TextStyle(fontSize: 12.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: ThemeController.tertiaryColor(),
                              ),
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                    onTap: ()=>Get.to(()=>const EditPreviousWorkWidget()),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.edit_outlined),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text(
                                          'edit',
                                          style: TextStyle(fontSize: 12.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
