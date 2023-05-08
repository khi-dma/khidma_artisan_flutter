class MessageModel {
  DateTime time;
  String content;
  int sender;
  MessageModel({required this.time, required this.content, required this.sender});

  Map<String, dynamic> toJson() {
    return {
      'date': time,
      'message': content,
      'sender': sender,
    };
  }

  static MessageModel fromJson(Map<String, dynamic> map) {
    return MessageModel(
      time: map['date'].toDate(),
      content: map['message'],
      sender: map['sender'],
    );
  }
}