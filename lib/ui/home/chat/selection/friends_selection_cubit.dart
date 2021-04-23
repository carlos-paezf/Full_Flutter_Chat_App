import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/data/stream_api_respository.dart';
import 'package:full_flutter_chat_app/domain/models/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserState{
  const ChatUserState(this.chatUser, {this.selected = false});
  final ChatUser chatUser;
  final bool selected;
}

class FriendsSelectionCubit extends Cubit<List<ChatUserState>> {
  FriendsSelectionCubit(this._streamApiRepository) : super([]);

  final StreamApiRepository _streamApiRepository;

  List<ChatUserState> get selectedUsers => state.where((element) => element.selected).toList();

  Future<void> init() async {
    final chatUsers = (await _streamApiRepository.getChatUser()).map((e) => ChatUserState(e));
    emit(chatUsers);
    //? final list = List.generate(10, (index) => ChatUserState(ChatUser(id: index.toString(), name:'Item: $index'))).toList();
    //? emit(list);
  }

  void selectedUser(ChatUserState chatUserState){
    final index = state.indexWhere((element) => element.chatUser.id == chatUserState.chatUser.id);
    state[index] = ChatUserState(state[index].chatUser, selected: !chatUserState.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createFriendChannel(ChatUserState chatUserState) async{
    return await _streamApiRepository.createSimpleChat(chatUserState.chatUser.id);
  }
}

class FriendsGroupCubit extends Cubit<bool>{
  FriendsGroupCubit() : super(false);

  void changeToGroup() => emit(!state);
}