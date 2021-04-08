import 'package:full_flutter_chat_app/data/auth_repository.dart';
import 'package:full_flutter_chat_app/data/stream_api_respository.dart';

class LoginUseCase {
  LoginUseCase(this.authRepository, this.streamApiRepository);

  final AuthRepository authRepository;
  final StreamApiRepository streamApiRepository;

  Future<bool> validateLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    return false;
  }
}