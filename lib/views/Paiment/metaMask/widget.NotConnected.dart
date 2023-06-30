import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/Local/controller.theme.dart';
import '../../../controllers/cryptoMoney/controller.wallet.dart';
import '../../Components/component.button.dart';

class ConnectWidget extends StatelessWidget {
  const ConnectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 170.sp,
            width: 170.sp,
            child: Image.asset("assets/images/MetaMask_Fox.png"),
          ),
          Text("You have to connect to MetaMask wallet",
            style: TextStyle(color: ThemeController.secondaryColor()),),
          SizedBox(height: 10.h),
          animatedButton(
              "Connect", controller.connect, controller.btnController)
        ],
      ),
    );
  }
}
