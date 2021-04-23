import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/data/image_picker_repository.dart';
import 'package:full_flutter_chat_app/domain/usecases/create_group_usecase.dart';
import 'package:full_flutter_chat_app/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionState {
  const GroupSelectionState(this.file, {this.channel});
  final File file;
  final Channel channel;
}

class GroupSelectionCubit extends Cubit<GroupSelectionState> {
  GroupSelectionCubit(this.members, this._createGroupUseCase, this._imagePickerRepository): super(GroupSelectionState(null));

  final nameTextController = TextEditingController();
  final List<ChatUserState> members;
  final CreateGroupUseCase _createGroupUseCase;
  final ImagePickerRepository _imagePickerRepository;

  void createGroup() async{
    final channel = await _createGroupUseCase.createGroup(CreateGroupInput(
      state.file, 
      nameTextController.text, 
      members.map((e) => e.chatUser.id).toList()));
    emit(GroupSelectionState(state.file, channel: channel));
  }

  void pickImage() async {
    final image = await _imagePickerRepository.pickImage();
    emit(GroupSelectionState(image));
  }
}