import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/cashedNetwork.dart';
import 'package:khidma_artisan_flutter/controllers/profileControllers/controller.portfolio.dart';
import 'package:sizer/sizer.dart';

import '../widget.addPreviousWork.dart';

Widget previousWorkWidgetModel(int index) {
  final controller = Get.find<PortfolioController>();
  return index < controller.portFolio.previousWork.length
      ? InkWell(
          onTap:()=> controller.toDetail(index),
          child: SizedBox(
            height: 90.sp,
            child: Hero(
              tag: "PWork$index",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7.sp),
                child: cachedNetworkModel(
                    controller.portFolio.previousWork[index].urlPic),
              ),
            ),
          ),
        )
      : Padding(
          padding: EdgeInsets.all(20.sp),
          child: InkWell(
              onTap: () => Get.to(() => const AddPreviousWorkWidget()),
              child: Opacity(
                opacity: index < 5 ? 1 :0.2 ,
                child: SvgPicture.asset(
                  "assets/icons/addPortfolio.svg",
                ),
              )),
        );
}
