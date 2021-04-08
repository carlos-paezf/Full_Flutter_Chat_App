import 'package:full_flutter_chat_app/data/stream_api_respository.dart';
import 'package:full_flutter_chat_app/domain/models/chart_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamApiLocalImpl extends StreamApiRepository {
  StreamApiLocalImpl(this._client);

  final StreamChatClient _client;

  @override
  Future<ChatUser> connectUser(ChatUser user, String token) async {
    Map<String, dynamic> extraData = {};
    if (user.image != null) {
      extraData['image'] = user.image;
    }
    if (user.name != null) {
      extraData['name'] = user.name;
    }
    await _client.connectUser(
      User(id: user.id, extraData: extraData), 
      //token ?? _client.devToken(user.id),
      token,
    );
    return user;
  }

  @override
  Future<List<ChatUser>> getChatUser() async {
    final result = await _client.queryUsers();
    final chatUsers = result.users
        .where((element) => element.id != _client.state.user.id)
        .map((e) =>
            ChatUser(id: e.id, name: e.name, image: e.extraData['image']))
        .toList();
    return chatUsers;
  }

  @override
  Future<String> getToken(String userId) async {
    return _client.devToken(userId);
  }

  @override
  Future<Channel> createGroupChat(String channelId, String name, List<String> members, {String image}) async {
    final channel = _client.channel('messaging', id: channelId, extraData: {
      'name': name,
      'image': image,
      'members': [_client.state.user.id, ...members],
    });
    await channel.watch();
    return channel;
  }

  @override
  Future<Channel> createSimpleChat(String friendId) async {
    final channel = _client.channel('messaging', id: '${_client.state.user.id.hashCode}${friendId.hashCode}', extraData: {
      'members': [
        friendId,
        _client.state.user.id,
      ],
    });
    await channel.watch();
    return channel;
  }

  @override
  Future<void> logout() {
    return _client.disconnect();
  }

  @override
  Future<bool> connectIfExist(String userId) async {
    return false;
  }
}