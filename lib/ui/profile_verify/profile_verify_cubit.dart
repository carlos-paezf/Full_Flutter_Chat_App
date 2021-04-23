import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:full_flutter_chat_app/data/image_picker_repository.dart';
import 'package:full_flutter_chat_app/domain/models/chat_user.dart';
import 'package:full_flutter_chat_app/domain/usecases/profile_sign_in_usecase.dart';

class ProfileState{
  const ProfileState(this.file, {this.success = false});
  final File file;
  final bool success;
}

class ProfileVerifyCubit extends Cubit<ProfileState>{
  ProfileVerifyCubit(this._imagePickerRepository, this._profileSignInUseCase) : super(ProfileState(null));

  final nameController = TextEditingController();
  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  void startChatting() async{
    final file = state.file;
    final name = nameController.text;
    await _profileSignInUseCase.verify(ProfileInput(imageFile: file, name: name));
    emit(ProfileState(file, success: true));
  }

  void pickImage() async {
    final file = await _imagePickerRepository.pickImage();
    emit(ProfileState(file));
  }

}