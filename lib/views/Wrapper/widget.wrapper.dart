import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wrapper/controller.wrapper.dart';
class WrapperWidget extends StatelessWidget {
  const WrapperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WrapperController());
    return controller.current();
  }
}
