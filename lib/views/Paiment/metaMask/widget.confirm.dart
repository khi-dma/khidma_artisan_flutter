import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/Local/controller.theme.dart';
import '../../../controllers/cryptoMoney/controller.wallet.dart';
import '../../Components/component.button.dart';

class ConfirmWidget extends StatelessWidget {
  const ConfirmWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 100.sp,
          width: 100.sp,
          child: Image.asset("assets/images/MetaMask_Fox.png"),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          controller.account.substring(0, 7) + ".....",
          style: TextStyle(
              color: ThemeController.secondaryColor(), fontSize: 13.sp),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: ThemeController.tertiaryColor(),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.balance.toString().substring(0, 7),
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                "  SepoliaETH",
                style: TextStyle(fontSize: 11.sp),
              ),
            ],
          ),
        ),
        const Spacer(),
        animatedButtonSecondary("Disconnect", controller.disconnect,
            controller.disconnectController),
        SizedBox(
          height: 3.h,
        ),
        animatedButton("Confirm", controller.addAddress,
            controller.btnController),
        SizedBox(
          height: 7.h,
        ),
      ],
    );
  }
}
