import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../models/model.chat.dart';

abstract class ChatAbstractController extends GetxController {
  final ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  late ChatModel selectedChat;

  RoundedLoadingButtonController bottomBtnController =
      RoundedLoadingButtonController();

  addMessage();

  updateRead();

  selectChat(ChatModel chat, int index);
}
