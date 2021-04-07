import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/domain/models/chart_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserState{
  const ChatUserState(this.chatUser, {this.selected = false});
  final ChatUser chatUser;
  final bool selected;
}

class FriendsSelectionCubit extends Cubit<List<ChatUserState>> {
  FriendsSelectionCubit() : super([]);

  //final StreamApiRepository streamApiRepository;

  List<ChatUserState> get selectedUsers => state.where((element) => element.selected).toList();

  Future<void> init() async {
    //TODO: Call Services
    final list = List.generate(10, (index) => ChatUserState(ChatUser(id: index.toString(), name:'Item: $index'))).toList();
    emit(list);
  }

  void selectedUser(ChatUserState chatUserState){
    final index = state.indexWhere((element) => element.chatUser.id == chatUserState.chatUser.id);
    state[index] = ChatUserState(state[index].chatUser, selected: !chatUserState.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createFriendChannel(ChatUserState chatUserState) async{
    //TODO: Call services
  }
}

class FriendsGroupCubit extends Cubit<bool>{
  FriendsGroupCubit() : super(false);

  void changeToGroup() => emit(!state);
}