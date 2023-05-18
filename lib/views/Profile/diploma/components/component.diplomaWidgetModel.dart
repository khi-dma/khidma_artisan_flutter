import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/cashedNetwork.dart';
import 'package:khidma_artisan_flutter/controllers/profileControllers/controller.diploma.dart';
import 'package:sizer/sizer.dart';

Widget diplomaWidgetModel(int index) {
  final controller = Get.find<DiplomaController>();

  return index < controller.diplomas.length
      ? InkWell(
          onTap:()=> controller.toDetail(index),
          child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Hero(
                      tag: index.toString() + "diploma",
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.sp),
                          child: cachedNetworkModel(
                              controller.diplomas[index].url)),
                    )),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    controller.icon(index),
                    size: 18.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ))
      : Padding(
          padding: EdgeInsets.all(20.sp),
          child: InkWell(
              onTap: controller.choosePic,
              child: Opacity(
                opacity: index < 5 ? 1 : 0.2,
                child: SvgPicture.asset(
                  "assets/icons/addPortfolio.svg",
                ),
              )),
        );
}
