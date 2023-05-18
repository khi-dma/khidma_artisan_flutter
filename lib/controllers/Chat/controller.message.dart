import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constWidgets/snackBar.dart';
import '../../models/model.chat.dart';
import '../../models/model.message.dart';
import '../../services/service.chat.dart';
import 'controller.abstractClass.dart';

class MessageController extends  ChatAbstractController {

  @override
  ChatModel selectedChat;
  MessageController({required this.selectedChat});


  @override
  addMessage() async {
    if (messageController.text.isNotEmpty) {
      var res = await ChatService.addMessage(
          MessageModel(
              time: DateTime.now(), content: messageController.text, sender: 1),
          selectedChat.uidChat);

      if (res.error) {
        snackBarModel("Failed", "Failed sending message", true);
      } else {
        messageController.clear();
      }
    }
  }



  @override
  void updateRead() async {
    await ChatService.updateRead(selectedChat.uidChat);
  }

  @override
  selectChat(ChatModel chat, int index) {}
}