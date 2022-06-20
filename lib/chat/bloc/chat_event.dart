part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final SendMessageModel sendMessageModel;

  SendMessage({required this.sendMessageModel});
}

class GetConversation extends ChatEvent {
  final GetConversationsModel getConversationsModel;

  GetConversation({required this.getConversationsModel});
}

class GetPreviousConversations extends ChatEvent {
  final GetPreviousConversationsModel getPreviousConversationsModel;

  GetPreviousConversations({required this.getPreviousConversationsModel});
}

class StartChat extends ChatEvent {
  final CreateConversationModel createConversationModel;

  StartChat({required this.createConversationModel});
}
