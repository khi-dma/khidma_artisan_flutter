import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../../constWidgets/cashedNetwork.dart';
import '../../../constWidgets/decoration.dart';
import '../../../controllers/Chat/controller.abstractClass.dart';
import '../../../models/model.message.dart';

Widget messageWidgetModel(
    MessageModel message, bool showPic, String otherUrl,ChatAbstractController controller) {
  bool _isUrl = Uri.parse(message.content).isAbsolute;
  return Align(
    alignment: message.sender == 1 ? Alignment.topRight : Alignment.topLeft,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: message.sender == 0,
          child: Row(
            children: [
              Visibility(
                visible: showPic,//messageBefore.sender == 0,
                child: SizedBox(
                  height: 30.sp,
                  width: 30.sp,
                  child: ClipOval(
                    child: cachedNetworkModel(otherUrl),
                  ),
                ),
                replacement: SizedBox(
                  width: 30.sp,
                ),
              ),
              SizedBox(
                width: 2.w,
              )
            ],
          ),
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.all(10.sp),
            decoration: defaultDecoration(
                4.sp,
                message.sender == 1 ? const Color(0xff425B59): const Color(0xfff1f1f1),
                false),
            width: message.sender == 1 ? 70.w : 60.w,
            child: _isUrl
                ? cachedNetworkModel(message.content)
                : Text(
              message.content,
              style: TextStyle(
                  color: message.sender == 0 ? Colors.black : Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
