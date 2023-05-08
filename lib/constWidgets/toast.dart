import 'package:fluttertoast/fluttertoast.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';



toast(String msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ThemeController.oppositeColor(),
    textColor: ThemeController.tertiaryColor(),
    fontSize: 16.0
);