import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../data/pallete.data.dart';

noItemWidgetModel() => Center(
      child: Text(
        "There are no items",
        style: TextStyle(
            fontSize: 12.sp, fontWeight: FontWeight.w600, color: kPrimaryColor),
      ),
    );
