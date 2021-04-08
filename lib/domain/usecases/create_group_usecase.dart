import 'dart:io';

import 'package:full_flutter_chat_app/data/stream_api_respository.dart';
import 'package:full_flutter_chat_app/data/upload_storage_repository.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateGroupInput {
  CreateGroupInput(this.imageFile, this.name, this.members);

  final File imageFile;
  final String name;
  final List<String> members;
}

class CreateGroupUseCase {
  CreateGroupUseCase(this._uploadStorageRepository, this._streamApiRepository);

  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;

  Future<Channel> createGroup(CreateGroupInput input) async {
    final channelId = Uuid().v4();
    final imageResult = await _uploadStorageRepository.uploadPhoto(input.imageFile, 'channels/$channelId');
    final channel = await _streamApiRepository.createGroupChat(channelId, input.name, input.members, image: imageResult);
    return channel;
  }
}