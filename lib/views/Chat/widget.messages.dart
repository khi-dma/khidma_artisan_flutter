import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/views/Chat/widgets/widget.appBarChat.dart';
import 'package:khidma_artisan_flutter/views/Chat/widgets/widget.inputState.dart';
import 'package:khidma_artisan_flutter/views/Chat/widgets/widget.topWidget.dart';
import 'package:sizer/sizer.dart';
import 'package:rxdart/rxdart.dart';
import '../../constWidgets/errorWidget.dart';
import '../../constWidgets/progressIndicator.dart';
import '../../controllers/Chat/controller.abstractClass.dart';
import '../../models/model.chat.dart';
import '../../models/model.message.dart';
import 'package:get/get.dart';

import 'components/component.messageModel.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key, required this.controller}) : super(key: key);
  final ChatAbstractController controller;

  @override
  _DetailDeliveryOrderState createState() => _DetailDeliveryOrderState();
}

class _DetailDeliveryOrderState extends State<MessageWidget> {
  late Stream<QuerySnapshot> messagesStream;
  late Stream<DocumentSnapshot> chatStream;
  late ChatAbstractController controller;
  late ChatModel chatSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = widget.controller;
    chatSelected = controller.selectedChat;

    messagesStream = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatSelected.uidChat)
        .collection("messages")
        .orderBy("date")
        .snapshots();
    chatStream = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatSelected.uidChat)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
        stream: CombineLatestStream.list([messagesStream, chatStream]),
        builder:
            (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return errorWidget();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgressModel();
          }

          List<MessageModel> messages = snapshot.data?[0].docs
              .map<MessageModel>((doc) =>
              MessageModel.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          ChatModel chat = ChatModel.fromJson(snapshot.data?[1].data() as Map<String, dynamic>);


          controller.updateRead();
          return Builder(
              builder: (context) {
                final bool isKeyboardVisible =
                    MediaQuery.of(context).viewInsets.bottom != 0;
                Future.delayed(const Duration(milliseconds: 100), () {
                  controller.scrollController.animateTo(
                    controller.scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                  );
                });
                return SafeArea(
                  child: Scaffold(
                    appBar: appBarChat(chat),
                    body:  Column(
                      children: [
                        topWidgetChat(chat, controller),
                        Expanded(
                            child: ListView.separated(
                                controller: controller.scrollController,
                                padding: EdgeInsets.only(
                                    left: 4.w, right: 4.w, top: 3.h),
                                itemCount: messages.length,
                                itemBuilder: (context, index) => messageWidgetModel(
                                    messages[index],
                                    chatSelected.picArtisan,
                                    controller),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                    SizedBox(height: 1.h))),
                        SizedBox(
                          height: 1.h,
                        ),
                        bottomWidgetChat(chat, controller)
                      ],
                    ),
                  ),
                );
              }
          );
        });
  }
}
