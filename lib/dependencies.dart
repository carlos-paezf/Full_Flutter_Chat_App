import 'dart:js';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'package:full_flutter_chat_app/data/auth_repository.dart';
import 'package:full_flutter_chat_app/data/image_picker_repository.dart';
import 'package:full_flutter_chat_app/data/persistent_storage_repository.dart';
import 'package:full_flutter_chat_app/data/stream_api_respository.dart';
import 'package:full_flutter_chat_app/data/upload_storage_repository.dart';

import 'package:full_flutter_chat_app/data/local/auth_local_impl.dart';
import 'package:full_flutter_chat_app/data/local/image_picker_impl.dart';
import 'package:full_flutter_chat_app/data/local/persistence_storage_local_impl.dart';
import 'package:full_flutter_chat_app/data/local/stream_api_local_impl.dart';
import 'package:full_flutter_chat_app/data/local/upload_storage_local_impl.dart';

import 'package:full_flutter_chat_app/domain/usecases/create_group_usecase.dart';
import 'package:full_flutter_chat_app/domain/usecases/login_usecase.dart';
import 'package:full_flutter_chat_app/domain/usecases/logout_usecase.dart';
import 'package:full_flutter_chat_app/domain/usecases/profile_sign_in_usecase.dart';


List<RepositoryProvider> buildRepositories(StreamChatClient client){
  return [
    RepositoryProvider<StreamApiRepository>(create: (_)=> StreamApiLocalImpl(client)),
    RepositoryProvider<PersistentStorageRepository>(create: (_)=> PersistentStorageLocalImpl()),
    RepositoryProvider<AuthRepository>(create: (_)=> AuthLocalImpl()),
    RepositoryProvider<UploadStorageRepository>(create: (_)=> UploadStorageLocalImpl()),
    RepositoryProvider<ImagePickerRepository>(create: (_)=> ImagePickerImpl()),
    RepositoryProvider<ProfileSignInUseCase>(
      create: (context)=> ProfileSignInUseCase(
        context.read(), context.read(), context.read(),
      ),
    ),
    RepositoryProvider<CreateGroupUseCase>(
      create: (context)=> CreateGroupUseCase(
        context.read(), context.read(),
      ),
    ),
    RepositoryProvider<LogoutUseCase>(
      create: (context)=> LogoutUseCase(
        context.read(), context.read(),
      )
    ),
    RepositoryProvider<LoginUseCase>(
      create: (context)=> LoginUseCase(
        context.read(), context.read(),
      )
    ),
  ];
}