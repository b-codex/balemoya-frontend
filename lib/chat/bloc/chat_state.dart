part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class MessageSent extends ChatState {}

class MessageNotSent extends ChatState {}