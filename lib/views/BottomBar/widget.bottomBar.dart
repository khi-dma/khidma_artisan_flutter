import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khidma_artisan_flutter/data/pallete.data.dart';
import 'package:khidma_artisan_flutter/views/Home/widget.home.dart';
import 'package:khidma_artisan_flutter/views/Posts/widget.posts.dart';
import 'package:khidma_artisan_flutter/views/Profile/widget.profile.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/Local/controller.theme.dart';
import '../Project/ProjectsList/widget.projectsList.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  var currentIndex = 0;
  List<Widget> screens = [
    const HomeWidget(),
    PostsWidget(),
    const ProjectListWidget(),
    const ProfileWidget()
  ];
  List<String> icons = [
    "home",
    "postBB",
    "project",
    "profile",
  ];

  List<String> listOfStrings = [
    'Home',
    'Posts',
    'Projects',
    'Account',
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        body: Stack(
          children: [
            screens[currentIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(displayWidth * .05),
                height: displayWidth * .155,
                decoration: BoxDecoration(
                  color: ThemeController.backgroundColor(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(7.sp),
                ),
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        HapticFeedback.lightImpact();
                      });
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex
                              ? displayWidth * .32
                              : displayWidth * .18,
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height:
                                index == currentIndex ? displayWidth * .12 : 0,
                            width:
                                index == currentIndex ? displayWidth * .32 : 0,
                            decoration: BoxDecoration(
                              color: index == currentIndex
                                  ? kPrimaryColor.withOpacity(.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4.sp),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex
                              ? displayWidth * .31
                              : displayWidth * .18,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    width: index == currentIndex
                                        ? displayWidth * .13
                                        : 0,
                                  ),
                                  AnimatedOpacity(
                                    opacity: index == currentIndex ? 1 : 0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: Text(
                                      index == currentIndex
                                          ? listOfStrings[index]
                                          : '',
                                      style: TextStyle(
                                        color: ThemeController.primaryColor(),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    width: index == currentIndex
                                        ? displayWidth * .03
                                        : 20,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/" + icons[index] + ".svg",
                                    height: index == 1
                                        ? displayWidth * .063
                                        : displayWidth * .065,
                                    width: displayWidth * .07,
                                    color: index == currentIndex
                                        ? ThemeController.primaryColor()
                                        : ThemeController.secondaryColor(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
