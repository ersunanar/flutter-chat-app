class TextMessage {
  //final String msgID;
  final String senderID;
  final String timestamp;
  final String message;
//required this.msgID,

  TextMessage({ required this.senderID, required this.timestamp, required this.message});
}



class ChatGroup {
  final String groupChatID;
  final String user1ID;
  final String user2ID;


  ChatGroup({required this.groupChatID, required this.user1ID, required this.user2ID});
}