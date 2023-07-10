import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
class PicViewWidget extends StatelessWidget {
  const PicViewWidget({required this.url,Key? key}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(url),
      ),
    ));
  }
}
