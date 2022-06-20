import 'dart:convert';

import 'package:balemoya/chat/models/models.dart';
import 'package:http/http.dart' as http;

class ChatProvider {
  static Future getName({required GetNameModel getNameModel}) async {
    var body = {"user": getNameModel.receiverID};

    var response = await http.post(
      Uri.parse(
          "http://192.168.8.194:8000/microservice/accountService/users/singleUser"),
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${getNameModel.token}",
      },
    );
    print('response.statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final String name = body['others']['fullName'];

      return name;
    } else {
      return null;
    }
  }

  static Future getConversation(
      {required GetConversationsModel getConversationsModel}) async {
    var response = await http.get(
        Uri.parse(
            "http://192.168.8.194:8000/microservice/chatService/users/conversation/${getConversationsModel.id}"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${getConversationsModel.token}"
        });
    if (response.statusCode == 200) {
      var rIDs = [];
      var body = json.decode(response.body);

      for (var conversations in body) {
        if (conversations['members'][1] != {getConversationsModel.id}) {
          rIDs.add(conversations['members'][1]);
        } else {
          rIDs.add(conversations['members'][0]);
        }

        // rIDs.add(conversations['members'][1]);
        // print(conversations['members']);
      }
      var rNames = [];

      for (var rID in rIDs) {
        var name = await getName(
          getNameModel: GetNameModel(
            token: getConversationsModel.token,
            receiverID: rID,
          ),
        );
        rNames.add(name);
      }

      return {
        'body': body,
        'rNames': rNames,
      };
    } else {
      return null;
    }
  }

  static Future getPreviousConversations(
      {required GetPreviousConversationsModel
          getPreviousConversationsModel}) async {
    var response = await http.get(
        Uri.parse(
            "http://192.168.8.194:8000/microservice/chatService/users/message/conversationId/${getPreviousConversationsModel.cID}"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${getPreviousConversationsModel.token}"
        });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future sendMessage({
    required SendMessageModel sendMessageModel,
  }) async {
    var body = {
      "conversation": sendMessageModel.cID,
      "text": sendMessageModel.message,
      "sender": sendMessageModel.senderID
    };
    var response = await http.post(
        Uri.parse(
            "http://192.168.8.194:8000/microservice/chatService/users/message/create"),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${sendMessageModel.token}"
        });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future startChat(
      {required CreateConversationModel createConversationModel}) async {
    var body = {
      "senderId": createConversationModel.senderID,
      "receiverId": createConversationModel.receiverID
    };

    var response = await http.post(
        Uri.parse(
            "http://192.168.8.194:8000/microservice/chatService/users/conversation/create"),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${createConversationModel.token}"
        });

    // print(body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
