import 'package:flutter/material.dart';

import 'package:balemoya/chat/models/models.dart';
import 'package:balemoya/chat/repository/repository.dart';
import 'package:balemoya/chat/screens/conversation_list.dart';

class ChatPage {
  static List<ChatUsers> chatUsers = [
    ChatUsers(
      name: "currentUser",
      imageURL: "images/userImage1.jpeg",
    ),
  ];

  static late String currentUser;
  static late String token;

  static setCurrentUser(String user) {
    currentUser = user;
  }

  static setToken(String token) {
    ChatPage.token = token;
  }

  static getCurrentUser() {
    return currentUser;
  }

  static returnWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search... $currentUser",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),

            FutureBuilder(
              // future: getConversation(token: token, id: getCurrentUser()),
              future: ChatRepository.getConversation(
                getConversationsModel: GetConversationsModel(
                  token: token,
                  id: getCurrentUser(),
                ),
              ),
              builder: (context, snapshot) {
                //check waiting state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  var res = snapshot.data as Map;
                  var chatList = res['body'];
                  var rNames = res['rNames'];
                  // print(rNames);

                  if (chatList.isNotEmpty) {
                    return ListView.builder(
                      itemCount: chatUsers.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // print(chatList[index]);

                        final String cID = chatList[index]["_id"];
                        final String sID = chatList[index]["members"][0];

                        return ConversationList(
                          name: rNames[index],
                          // name: '',
                          imageUrl:
                              "https://flyinryanhawks.org/wp-content/uploads/2016/08/profile-placeholder.png",
                          sID: sID,
                          cID: cID,
                          token: token,
                        );
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        const Center(
                          child: Text("No Conversations"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // startChat(
                            //   senderID: currentUser,
                            //   receiverID: '62aeeb5c5877361e6569c59d',
                            //   token: token,
                            // ).then((value) {
                            //   print(value);
                            // });
                          },
                          child: const Text("Start Chat"),
                        )
                      ],
                    );
                  }
                } else {
                  return const Center(
                    child: Text("No Conversations"),
                  );
                }
              },
            ),

            //future builder to get conversations
          ],
        ),
      ),
    );
  }
}
