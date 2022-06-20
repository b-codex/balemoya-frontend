import 'package:balemoya/chat/models/models.dart';
import 'package:balemoya/chat/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<SendMessage>((event, emit) async{
      final response = await chatRepository.sendMessage(sendMessageModel: event.sendMessageModel);
      if(response != null){
        emit(MessageSent());
      } else {
        emit(MessageNotSent());
      }
    });

    on<GetConversation>((event, emit) async{
      final response = await ChatRepository.getConversation(getConversationsModel: event.getConversationsModel);
      // emit(response);
    });

    on<GetPreviousConversations>((event, emit) async{
      final response = await ChatRepository.getPreviousConversations(getPreviousConversationsModel: event.getPreviousConversationsModel);
      // emit(response);
    });

    on<StartChat>((event, emit) async{
      final response = await chatRepository.startChat(createConversationModel: event.createConversationModel);
      // emit(response);
    });
  }
}
