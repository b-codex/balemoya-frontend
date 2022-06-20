import 'package:balemoya/chat/models/models.dart';
import 'package:balemoya/chat/provider/provider.dart';

class ChatRepository {
  final ChatProvider chatProvider;

  ChatRepository({required this.chatProvider});

  Future sendMessage({required SendMessageModel sendMessageModel}) async {
    return await chatProvider.sendMessage(sendMessageModel: sendMessageModel);
  }

  static Future getConversation({required GetConversationsModel getConversationsModel}) async {
    return await ChatProvider.getConversation(getConversationsModel: getConversationsModel);
  }

  static Future getPreviousConversations({required GetPreviousConversationsModel getPreviousConversationsModel}) async {
    return await ChatProvider.getPreviousConversations(getPreviousConversationsModel: getPreviousConversationsModel);
  }

  Future startChat({required CreateConversationModel createConversationModel}) async {
    return await ChatProvider.startChat(createConversationModel: createConversationModel);
  }

}
