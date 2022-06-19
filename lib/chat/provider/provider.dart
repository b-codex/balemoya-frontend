import 'dart:convert';

import 'package:balemoya/chat/models/models.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

class ChatProvider {
  Future getChat(GetConversationsForUser getConversationsForUser) async {
    var url = '$apiRoute/chatService/users/conversation/conversationID';
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getConversationsForUser.sessionID[1]}',
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future sendMessage(SendMessage sendMessage) async {
    var url = '$apiRoute/chatService/users/conversation/conversationID';
    try {
      var response = await http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sendMessage.sessionID[1]}',
      }, body: {
        'text': sendMessage.text,
        'conversation': sendMessage.conversationID,
        'sender': sendMessage.senderID,
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      }
    } catch (error) {
      print(error);
      return [];
    }
  }
}
