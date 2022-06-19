class GetConversationsForUser {
  final String userID;
  final String sessionID;

  GetConversationsForUser({required this.userID, required this.sessionID});
}

class GetBothUsers {
  final String userOneID;
  final String userTwoID;

  GetBothUsers({
    required this.userOneID,
    required this.userTwoID,
  });
}

class CreateConversation {
  final String senderID;
  final String receiverID;
  final String sessionID;

  CreateConversation({
    required this.senderID,
    required this.receiverID,
    required this.sessionID,
  });
}

class SendMessage {
  final String conversationID;
  final String text;
  final String senderID;
  final String sessionID;

  SendMessage({
    required this.conversationID,
    required this.text,
    required this.senderID,
    required this.sessionID,
  });
}

class ChatMessage {
  final String message;
  final String senderUsername;
  final DateTime sentAt;
  final String messageType;
  ChatMessage({
    required this.message,
    required this.senderUsername,
    required this.sentAt,
    required this.messageType,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'] as String,
      senderUsername: json['senderUsername'] as String,
      sentAt: DateTime.fromMillisecondsSinceEpoch(json['sentAt'] * 1000),
      // messageType: json['messageType'] ? "receiver" : "sender",
      messageType: "sender",
    );
  }
}

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
  });
}

