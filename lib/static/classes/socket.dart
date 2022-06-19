// ignore_for_file: avoid_print
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'package:the_gram/models/chat_message_model.dart';

class Socket {
  static String _sender = '';

  static setSender(String sender) {
    _sender = sender;
  }

  static _getSender() {
    return _sender;
  }

  static final io.Socket socket = io.io(
      '$apiRoute/chatService',
      io.OptionBuilder().setTransports(['websocket']).setQuery({
        'username': _getSender(),
      }).build());
  // static final io.Socket socket = io.io(
  //   'http://192.168.8.100:3000',
  //   <String, dynamic>{
  //     'transports': ['websocket']
  //   },
  // );

  static connectSocket() {
    socket.onConnect(((data) => print('Connected')));
    socket.onConnectError((data) => print("Connect error: $data"));
    socket.onDisconnect((data) => print("Disconnected: $data"));

    socket.on('message', (data) {
      // var msg = ChatMessage.fromJson(data);
      // print(msg.message);
      // print(msg.messageType);
      // print(msg.senderUsername);
    });
  }

  // void emit(String event, [dynamic data]) {
  //   socket.emit(event, data);
  // }

  // void on(String event, Function callback) {
  //   socket.on(event, (data) {
  //     print(data);
  //   });
  // }

  // void off(String event) {
  //   socket.off(event);
  // }

  void close() {
    socket.close();
  }
}
