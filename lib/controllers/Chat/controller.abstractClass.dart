import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/model.chat.dart';

abstract class ChatAbstractController extends GetxController{
  final ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  late ChatModel selectedChat;
  addMessage();
  updateRead();
  selectChat(ChatModel chat,int index);
}