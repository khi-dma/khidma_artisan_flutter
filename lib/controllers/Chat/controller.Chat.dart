import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../constWidgets/snackBar.dart';
import '../../models/model.chat.dart';
import '../../models/model.message.dart';
import '../../services/service.chat.dart';
import '../../views/Chat/widget.messages.dart';
import 'controller.abstractClass.dart';

class ChatController extends ChatAbstractController {
  var downloading = false.obs;
  var uploading = false.obs;
  var error = false.obs;
  int idPost;

  List<ChatModel> chats = [];

  @override
  onInit() {
    super.onInit();
    getChats();
  }
  ChatController({this.idPost=-1});


  getChats() async {
    switchState(0);
    var res = await ChatService. getChats(idPost);
    error.value = res.error;
    chats=res.data;
    chats.reversed;
    switchState(0);
  }

  @override
  selectChat(ChatModel chat,int index) {
    selectedChat = chat;
    chats
        .where((chat) => chat.uidChat == selectedChat.uidChat)
        .toList()
        .first
        .readArtisan = true;
    update(["chat"]);
    Get.to(() => MessageWidget(controller: this,));
  }

  switchState(int state) {
    if (state == 0) {
      downloading.value = !downloading.value;
    } else {
      uploading.value = !uploading.value;
    }
  }


  @override
  addMessage() async {
    switchState(1);
    if (messageController.text.isNotEmpty) {
      var res = await ChatService.addMessage(
          MessageModel(
              time: DateTime.now(), content: messageController.text, sender: 1),
          selectedChat.uidChat);
      if (res.error) {
        snackBarModel("Failed", "Failed sending message", true);
      } else {
        chats
            .where((chat) => chat.uidChat == selectedChat.uidChat)
            .toList()
            .first
            ..lastMessage = messageController.text..lastMessageDate= DateTime.now();

        update(["chat"]);
        messageController.clear();
      }
    }
    switchState(1);
  }

  @override
  void updateRead() async {
    await ChatService.updateRead(selectedChat.uidChat);
  }

}
