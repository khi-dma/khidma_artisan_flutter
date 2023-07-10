import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/emptyList.dart';
import 'package:sizer/sizer.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2.h),
        Text(
          "Notifications",
          style: TextStyle(fontSize: 17.sp),
        ),
        Spacer(),
        emptyListWarning(),
        Spacer(),
      ],
    );
  }
}
