import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../../constWidgets/cashedNetwork.dart';
import '../../../constWidgets/decoration.dart';
import '../../../controllers/Chat/controller.abstractClass.dart';
import '../../../data/fonc.data.dart';
import '../../../models/model.message.dart';

Widget messageWidgetModel(
    MessageModel message, String otherUrl,ChatAbstractController controller) {
  bool _isUrl = Uri.parse(message.content).isAbsolute;
  String date = dateToStringMessage(message.time.toString());
  bool showDate = false;
  bool sender = message.sender == 1;
  return Align(
    alignment: sender ? Alignment.topRight : Alignment.topLeft,
    child: StatefulBuilder(builder: (context, StateSetter setState) {
      return InkWell(
        onTap: () {
          setState(() => showDate = !showDate);
        },
        child: SizedBox(
          width: 70.w,
          child: Column(
            crossAxisAlignment:sender? CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp)
                ),
                margin: EdgeInsets.zero,
                color: sender
                    ? const Color(0xff425B59)
                    : const Color(0xfff1f1f1),
                child: Padding(
                  padding: EdgeInsets.all(_isUrl ? 4.sp : 7.sp),
                  child: _isUrl
                      ? ClipRRect(
                      borderRadius: BorderRadius.circular(5.sp),
                      child: cachedNetworkModel(message.content))
                      : Text(
                    message.content,
                    style: TextStyle(
                        color: !sender
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                firstChild: Text(date),
                secondChild: const SizedBox(),
                crossFadeState: showDate
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ],
          ),
        ),
      );
    }),
  );
}
