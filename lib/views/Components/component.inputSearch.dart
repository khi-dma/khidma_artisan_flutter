
import 'package:flutter/material.dart';
import '../../../data/font.data.dart';
import '../../../data/pallete.data.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/Local/controller.theme.dart';

class InputSearchComponent extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String)? change;
  final Function(String)? submitted;
  final String hint;
  final bool readOnly;
  final Function()? onTap;
  final FocusNode? focusNode;
  const InputSearchComponent(
      {Key? key, this.focusNode,this.onTap,this.readOnly=false,required this.textEditingController,required this.hint,
         this.change, this.submitted}) : super(key: key);

  @override
  State<InputSearchComponent> createState() => _InputSearchComponentState();
}

class _InputSearchComponentState extends State<InputSearchComponent> {
  bool showClear = false;
  switchShow(String value){
    setState(() {
      showClear = value.isNotEmpty;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: TextField(
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        onSubmitted:widget.submitted,
        onChanged:switchShow,
        cursorColor: kSecondBlueColor,
        controller: widget.textEditingController,
        style: TextStyle(fontSize: 11.5.sp, fontWeight: regular),
        decoration:  InputDecoration(
          suffixIconConstraints: BoxConstraints(
              minHeight: 12.sp,
              minWidth: 24
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: showClear,
                child: InkWell(
                  onTap: (){
                    widget.textEditingController.clear();
                    widget.submitted!("");
                    switchShow("");
                  },
                  child: Padding(
                    padding:  EdgeInsets.only(right: 4.w),
                    child: Icon(Icons.clear,color: ThemeController.tertiaryColor()),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: 4.w),
                child: SvgPicture.asset("assets/icons/search.svg",color: ThemeController.tertiaryColor()),
              ),

            ],
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 7.w,vertical: 2.h),
          hintText: widget.hint,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.sp),
              borderSide: BorderSide(color: ThemeController.backgroundColor(), width: 1.sp)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.sp),
              borderSide: BorderSide(color: ThemeController.backgroundColor(),width: 1.sp)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.sp),
              borderSide: BorderSide(color: ThemeController.backgroundColor(),width: 0.5.sp)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.sp),
              borderSide: BorderSide(color: ThemeController.backgroundColor(),width: 0.5.sp)),
          filled: true,
        ),
      ),
    );
  }
}
