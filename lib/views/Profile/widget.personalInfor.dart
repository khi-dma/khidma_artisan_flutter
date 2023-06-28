import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/views/Profile/widget.edit.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../constWidgets/cashedNetwork.dart';
import '../../controllers/Local/controller.theme.dart';
import '../../controllers/profile/controller.profil.dart';
import '../../data/font.data.dart';

Widget personalInformation() {
  final controller = Get.find<ProfileController>();
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7.sp)
    ),
    child: GetBuilder(
      init: controller,
      id: "personalInformation",
      builder: (context) {
        return ListTile(
          onTap: ()=>Get.to(()=>const EditProfile(),transition: Transition.cupertino),
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.7.h),
          leading: SizedBox(
            height: 40.sp,
            width: 40.sp,
            child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.sp),
                  child: cachedNetworkModel(controller.user.profilePicture),
                ),
          ),
          title: Text(
            controller.user.firstName + " " + controller.user.lastName,
            style: TextStyle(fontSize: 13.sp,fontWeight: medium),
          ),
          subtitle: Text(
            "View my profile",
            style: TextStyle(fontSize: 10.sp,color: ThemeController.secondaryColor()),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded,size: 14.sp,),
        );
      }
    ),
  );
}
