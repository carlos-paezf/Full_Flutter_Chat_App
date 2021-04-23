import 'dart:io';
import 'package:full_flutter_chat_app/data/upload_storage_repository.dart';

class UploadStorageLocalImpl extends UploadStorageRepository {
  @override
  Future<String> uploadPhoto(File file, String path) async {
    return 'https://avatars.githubusercontent.com/u/55883267?v=4';
  }
}