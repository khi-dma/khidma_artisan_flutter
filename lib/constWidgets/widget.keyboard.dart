import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/constWidgets/appBar.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/const.data.dart';

// ignore: must_be_immutable
class KeyboardWidget extends StatefulWidget {
  KeyboardWidget(this.amount,this.function, {Key? key}) : super(key: key);
  String amount;
  StringParameterFunction function;

  @override
  _KeyboardWidgetState createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  bool first = true;

  _onKeyboardTap(String value) {
    setState(() {
      if (first) {
        first = false;
        widget.amount = "";
      }
      if(widget.amount.isEmpty && value =="0"){

      }else{
        widget.amount += value;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBarModel('Price'),
      body: Column(
        children: [
          Expanded(
            child: Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(widget.amount,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500)),
            )),
          ),
          NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: ThemeController.oppositeColor(),
              rightButtonFn: () {
                setState(() {
                  first = false;
                  if (widget.amount.isNotEmpty) {
                    widget.amount =
                        widget.amount.substring(0, widget.amount.length - 1);
                  }
                });
              },
              rightIcon: const Icon(Icons.backspace),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 4.h,horizontal: 4.w),
            child: button("Save", (){
              widget.function(widget.amount);
              Get.back();
            }),
          )
        ],
      ),
    ));
  }
}
