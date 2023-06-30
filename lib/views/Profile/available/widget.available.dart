import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/constWidgets/errorWidget.dart';
import 'package:khidma_artisan_flutter/constWidgets/progressIndicator.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/profile/controller.availability.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Components/component.input.dart';

class AvailableWidget extends StatelessWidget {
  const AvailableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AvailabilityController());
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel("Availability"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Obx(
            () => controller.downloading.isTrue
                ? circularProgressModel()
                : controller.error.isTrue
                    ? errorWidget()
                    : Column(
                        children: [
                          Obx(
                            () => RadioListTile(
                              value: controller.availability.schedule.isTrue
                                  ? 1
                                  : 0,
                              groupValue: 0,
                              onChanged: controller.updateStatus,
                              title: Text(
                                "Simple status",
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Opacity(
                                opacity: controller.availability.schedule.isTrue
                                    ? 0.4
                                    : 1,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.sp),
                                          border: Border.all(
                                              width: 1.sp,
                                              color: ThemeController
                                                  .tertiaryColor())),
                                      child: SwitchListTile(
                                        activeColor: Colors.green,
                                        title: const Text('Available'),
                                        value: controller
                                            .availability.available.value,
                                        onChanged: controller
                                            .updateAvailabilitySimpleStatus,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Visibility(
                                        visible: controller.availability
                                                .schedule.isFalse &&
                                            controller
                                                .availability.available.isFalse,
                                        child: InputComponent(
                                          textEditingController:
                                              controller.noteController,
                                          hintText:
                                              'Optional : Add note to client',
                                          labelShow: false,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Obx(
                            () => RadioListTile(
                              value: controller.availability.schedule.isTrue
                                  ? 1
                                  : 0,
                              groupValue: 1,
                              onChanged: controller.updateStatus,
                              title: Text(
                                "Schedule status",
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Obx(
                            () => Opacity(
                              opacity: controller.availability.schedule.isFalse
                                  ? 0.4
                                  : 1,
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.sp),
                                    border: Border.all(
                                        width: 1.sp,
                                        color:
                                            ThemeController.tertiaryColor())),
                                child: GetBuilder(
                                    init: controller,
                                    id: 'weekday',
                                    builder: (context) {
                                      return Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: controller
                                            .availability.weekday.entries
                                            .map((entry) => InkWell(
                                                  onTap: () => controller
                                                      .switchWeekDay(entry.key),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.sp),
                                                        color: entry.value
                                                            ? ThemeController
                                                                .greenSecondColor()
                                                            : Colors
                                                                .transparent),
                                                    padding:
                                                        EdgeInsets.all(10.sp),
                                                    child: Text(entry.key),
                                                  ),
                                                ))
                                            .toList(),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Obx(
                              () => SwitchListTile(
                                activeColor: Colors.green,
                                title: const Text('Receive offers offline'),
                                value:
                                    controller.availability.receiveOffers.value,
                                onChanged:
                                    controller.updateReceiveOffersOffline,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: animatedButton("Save", controller.save,
                                controller.btnController),
                          ),
                          SizedBox(height: 4.h),
                        ],
                      ),
          ),
        ),
      ),
    ));
  }
}
