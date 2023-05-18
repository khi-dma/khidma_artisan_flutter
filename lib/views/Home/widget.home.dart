import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/HomeController/controller.home.dart';
import 'package:khidma_artisan_flutter/views/Home/widget.appBar.dart';
import 'package:sizer/sizer.dart';

import 'components/component.search.dart';
import 'components/component.title.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        SizedBox(height: 3.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            children: [
              appBarHome(),
              SizedBox(height: 3.h),
              //searchBar(),
              SizedBox(height: 3.h),
              //titleSeeAll("Services",const ServiceWidget()),
            ],
          ),
        ),
        //serviceHome(),

      ],
    );
  }
}
