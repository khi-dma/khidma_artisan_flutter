import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/views/Paiment/metaMask/widget.NotConnected.dart';
import 'package:khidma_artisan_flutter/views/Paiment/metaMask/widget.confirm.dart';
import 'package:sizer/sizer.dart';
import '../../../constWidgets/appBar.dart';
import '../../../constWidgets/progressIndicator.dart';
import '../../../controllers/cryptoMoney/controller.wallet.dart';
import '../../../models/model.project.dart';

class MetaMaskWidget extends StatelessWidget {
  const MetaMaskWidget({ Key? key}) : super(key: key);

  ////0 edit profile , 1 connect

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletController());
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Obx(() {
              if (controller.downloading.isTrue) {
                return circularProgressModel();
              }
              if (controller.connected.isTrue) {
                return const ConfirmWidget();
              } else {
                return const ConnectWidget();
              }
            }),
          )),
    );
  }
}
