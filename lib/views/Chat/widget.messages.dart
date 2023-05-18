import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constWidgets/appBar.dart';
import '../../constWidgets/errorWidget.dart';
import '../../constWidgets/progressIndicator.dart';
import '../../controllers/Chat/controller.abstractClass.dart';
import '../../controllers/LocalController/controller.theme.dart';
import '../../models/model.chat.dart';
import '../../models/model.message.dart';
import 'package:get/get.dart';

import '../Components/component.inputChat.dart';
import 'components/component.messageModel.dart';

class MessageWidget extends StatefulWidget {
  MessageWidget({Key? key, required this.controller}) : super(key: key);
  ChatAbstractController controller;

  @override
  _DetailDeliveryOrderState createState() => _DetailDeliveryOrderState();
}

class _DetailDeliveryOrderState extends State<MessageWidget> {
  late Stream<QuerySnapshot> orderStream;
  late ChatAbstractController controller;
  late ChatModel chat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = widget.controller;
    chat = controller.selectedChat;
    if (chat.lastMessage.isEmpty) {
      getChat();
    }

    orderStream = FirebaseFirestore.instance
        .collection('chats')
        .doc(chat.uidChat)
        .collection("messages")
        .orderBy("date")
        .snapshots();
  }

  bool downloading = false;

  getChat() async {
    setState(() {
      downloading = true;
    });
    var chatDocument = await FirebaseFirestore.instance
        .collection('chats')
        .doc(controller.selectedChat.uidChat)
        .get();
    ChatModel chat =
    ChatModel.fromJson(chatDocument.data() as Map<String, dynamic>);
    controller.selectedChat = chat;
    this.chat = controller.selectedChat;
    setState(() {
      downloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
        child: downloading
            ? circularProgressModel()
            : Scaffold(
          appBar: appBarModel(chat.titleChat),
          body: GetBuilder(
              init: controller,
              builder: (context) {
                return StreamBuilder<QuerySnapshot>(
                  stream: orderStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return errorWidget();
                    }

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return circularProgressModel();
                    }

                    List<MessageModel> messages = snapshot.data!.docs
                        .map((doc) => MessageModel.fromJson(
                        doc.data() as Map<String, dynamic>))
                        .toList();

                    Future.delayed(const Duration(milliseconds: 100), () {
                      controller.scrollController.animateTo(
                        controller
                            .scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                      );
                    });
                    controller.updateRead();

                    return Column(
                      children: [
                        Expanded(
                            child: ListView.separated(
                              controller: controller.scrollController,
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              itemCount: messages.length,
                              itemBuilder: (context, index) =>
                                  messageWidgetModel(
                                      messages[index],
                                      index == 0
                                          ? true
                                          : messages[index - 1].sender == 1,
                                      chat.picArtisan,
                                      controller),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                  SizedBox(
                                    height: 1.h,
                                  ),
                            )),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          padding: EdgeInsets.all(5.sp),
                          color:
                          ThemeController.backScaffoldGroundColor(),
                          child: InputChat(
                              textEditingController:
                              controller.messageController,
                              function: controller.addMessage),
                        )
                      ],
                    );
                  },
                );
              }),
        ));
  }
}
