import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:get/get.dart';

Widget dialogMetaMask(){
  return SizedBox(
    width: Get.context!.mediaQuery.size.width * 0.9,
    child: Center(
        child: SizedBox(
          height: 30.h,
          width: 70.w,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    // width: OneContext().mediaQuery.size.width * 0.5,
                    child: Text(
                      "MetaMask App is require for the app to work correctly please istall MetaMask Application and restart the app.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        StoreRedirect.redirect(
                            androidAppId: "io.metamask",
                            iOSAppId: "1438144202");
                        Navigator.of(Get.context!,
                            rootNavigator: true)
                            .pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Close"),
                      ))
                ],
              ),
            ),
          ),
        )),
  );
}