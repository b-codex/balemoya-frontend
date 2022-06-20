import 'package:balemoya/chat/bloc/chat_bloc.dart';
import 'package:balemoya/chat/repository/repository.dart';
import 'package:balemoya/chat/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:balemoya/chat/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../provider/provider.dart';

class ChatDetailPage extends StatefulWidget {
  final String chatWith;
  final String sID;
  final String cID;
  final String token;

  const ChatDetailPage({
    Key? key,
    required this.chatWith,
    required this.sID,
    required this.cID,
    required this.token,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    bool sentBy({required senderID}) {
      // print("sender id is $senderID");
      // print("current user from chat page is ${ChatPage.getCurrentUser()}");
      // print("get id from chat page is ${ChatPage.getId()}");
      // print('rID id ${widget.rID}');
      if (senderID != ChatPage.getCurrentUser()) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://flyinryanhawks.org/wp-content/uploads/2016/08/profile-placeholder.png",
                  ),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.chatWith,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      // Text(
                      //   "Online",
                      //   style: TextStyle(
                      //       color: Colors.grey.shade600, fontSize: 13),
                      // ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData && !snapshot.hasError) {
              TextEditingController messageController = TextEditingController();

              var response = snapshot.data as List;
              List<ChatMessage> messages = [];

              for (var message in response) {
                messages.add(
                  ChatMessage(
                    message: message['text'],
                    senderID: message['sender'],
                    sentByMe: sentBy(senderID: message['sender']),
                  ),
                );
              }

              return Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ListView.builder(
                        // reverse: true,
                        itemCount: messages.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (messages[index].sentByMe
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (messages[index].sentByMe
                                      ? Colors.grey.shade200
                                      : Colors.indigo[200]),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  messages[index].message,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        bottom: 10,
                        top: 10,
                      ),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              if (messageController.text.trim().isNotEmpty) {
                                // print('sender id is ${ChatPage.getCurrentUser()}');
                                final bloc = BlocProvider.of<ChatBloc>(context);
                                bloc.add(
                                  SendMessage(
                                    sendMessageModel: SendMessageModel(
                                      cID: widget.cID,
                                      message: messageController.text.trim(),
                                      senderID: ChatPage.getCurrentUser(),
                                      token: widget.token,
                                    ),
                                  ),
                                );

                                // sendMessage(
                                //   message: messageController.text.trim(),
                                //   cID: widget.cID,
                                //   token: widget.token,
                                //   senderID: ChatPage.getCurrentUser(),
                                // ).then((value) => messageController.clear());
                              }
                            },
                            backgroundColor: Colors.indigo,
                            elevation: 0,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: Text("Nothing Yet."),
            );
          }
        }),
        future: ChatRepository.getPreviousConversations(
          getPreviousConversationsModel: GetPreviousConversationsModel(
            token: widget.token,
            cID: widget.cID,
          ),
        ),
      ),
    );
  }
}
