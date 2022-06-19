class GetConversationsModel {
  final String token;
  final String id;

  GetConversationsModel({required this.token, required this.id});
}

class GetNameModel {
  final String token;
  final String receiverID;

  GetNameModel({required this.token, required this.receiverID});
}

class GetPreviousConversationsModel {
  final String token;
  final String cID;

  GetPreviousConversationsModel({required this.token, required this.cID});
}

class CreateConversationModel {
  final String senderID;
  final String receiverID;
  final String token;

  CreateConversationModel({
    required this.senderID,
    required this.receiverID,
    required this.token,
  });
}

class SendMessageModel {
  final String cID;
  final String message;
  final String senderID;
  final String token;

  SendMessageModel({
    required this.cID,
    required this.message,
    required this.senderID,
    required this.token,
  });
}

class ChatMessage {
  final String message;
  final String senderID;
  final bool sentByMe;
  ChatMessage({
    required this.message,
    required this.senderID,
    this.sentByMe = false,
  });
  //get sessionID from shared preferences

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'] as String,
      senderID: json['senderID'] as String,
    );
  }
}

class ChatUsers {
  String name;
  String imageURL;
  ChatUsers({
    required this.name,
    required this.imageURL,
  });
}
