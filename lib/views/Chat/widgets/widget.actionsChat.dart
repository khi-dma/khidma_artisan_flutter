import 'package:flutter/material.dart';
import '../../../models/model.chat.dart';
import '../../../services/service.chat.dart';

Widget actionChat(ChatModel chat){
  return  PopupMenuButton<String>(
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(
         onTap: (){
           ChatService.changeState(chat,3);
         },
        child:  const Text('Bloc chat'),
      ),

    ],
  );
}
