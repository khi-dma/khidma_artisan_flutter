import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/LocalController/controller.local.dart';
import '../models/general.dart';
import '../models/model.chat.dart';
import '../models/model.message.dart';


class ChatService {
 static  CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chats");

  static Future<General<List<ChatModel>>> getChats(int idPost) async {
    try {
      late QuerySnapshot<Object?> data ;
      List<ChatModel> chats = [];
      if(idPost==-1){
        data = await chatCollection.where("uidArtisan",isEqualTo: LocalController.getUid()).orderBy("lastMessageDate").get();
      }else{
        data = await chatCollection.where("uidArtisan",isEqualTo: LocalController.getUid()).where("idPost",isEqualTo: idPost).orderBy("lastMessageDate").get();

      }
      chats = data.docs
          .map(
              (chat) => ChatModel.fromJson(chat.data() as Map<String, dynamic>))
          .toList();
      return General(data: chats);
    } catch (e) {
      return General(data: [], error: true);
    }
  }

 static Future<General<String>> addMessage(MessageModel message,String chatUID)async {
   try{
     chatCollection.doc(chatUID).collection("messages").add(message.toJson());
     chatCollection.doc(chatUID).update({
       "lastMessage":message.content,
       "lastMessageDate":message.time,
     });
     return General(data: "");
   }catch(e){
     return General(data: "", error: true);
   }
 }

 static Future<General<String>> updateRead(String chatUID)async  {
   try{
     await chatCollection.doc(chatUID).update({
       "readArtisan":true,
     });
     return General(data: "");
   }catch(e){
     return General(data: "", error: true);
   }
 }
}
