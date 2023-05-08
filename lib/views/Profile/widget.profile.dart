import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/views/Profile/widget.work.dart';
import 'package:khidma_artisan_flutter/views/Profile/widget.personalInfor.dart';
import 'package:khidma_artisan_flutter/views/Profile/widget.settings.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

import '../../controllers/profileControllers/controller.profilController.dart';


class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      child: GetBuilder(
        init: controller,
        builder: (context) {
          return Column(
            children: [
              personalInformation(),
              SizedBox(height: 3.h),
              workProfile(),
              SizedBox(height: 3.h),
              settings(),
            ],
          );
        }
      ),
    );
  }
}
