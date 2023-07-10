import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Client/controller.client.dart';
import 'package:khidma_artisan_flutter/models/model.client.dart';
import 'package:sizer/sizer.dart';
import '../../constWidgets/cashedNetwork.dart';
import '../../constWidgets/picView.dart';
import '../../controllers/Local/controller.theme.dart';
import '../../data/font.data.dart';

Widget personalInformationClient() {
  final controller = Get.find<ClientDetailController>();
  final selectedClient = controller.client;
  return SizedBox(
    width: double.infinity,
    child: Column(
      children: [
        SizedBox(
          width: 60.sp,
          height: 60.sp,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.sp),
            child: cachedNetworkModel(selectedClient.profilePicture, true),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          selectedClient.name,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(fontSize: 13.sp, fontWeight: regular),
        ),
      ],
    ),
  );
}
