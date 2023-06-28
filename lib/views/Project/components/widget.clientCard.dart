import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:khidma_artisan_flutter/models/model.client.dart';
import 'package:khidma_artisan_flutter/models/model.user.dart';
import 'package:sizer/sizer.dart';
import '../../../constWidgets/cashedNetwork.dart';

Widget clientCard(ClientModel client) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Client',
        style: TextStyle(fontSize: 13.sp,color: ThemeController.secondaryColor()),
      ),
      SizedBox(height: 0.5.h),
      Card(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(9.sp)),
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: ClipOval(
            child: cachedNetworkModel(client.profilePicture),
          ),
          title: Text(client.name),
          subtitle: Text(
            "0" + client.phoneNumber.toString(),
            style: TextStyle(
                fontSize: 11.sp, color: ThemeController.secondaryColor()),
          ),
        ),
      ),
    ],
  );
}

Widget artisanCard(UserModel artisan) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Artisan',
        style: TextStyle(fontSize: 13.sp,color: ThemeController.secondaryColor()),
      ),
      SizedBox(height: 0.5.h),
      Card(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(9.sp)),

        margin: EdgeInsets.zero,
        child: ListTile(
          leading: ClipOval(
            child: cachedNetworkModel(artisan.profilePicture),
          ),
          title: Text(artisan.lastName +" "+  artisan.firstName),
          subtitle: Text(
            "0" + artisan.phoneNumber.toString(),
            style: TextStyle(
                fontSize: 11.sp, color: ThemeController.secondaryColor()),
          ),
        ),
      ),
    ],
  );
}

