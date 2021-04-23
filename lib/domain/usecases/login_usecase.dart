import 'package:full_flutter_chat_app/data/auth_repository.dart';
import 'package:full_flutter_chat_app/data/stream_api_respository.dart';
import 'package:full_flutter_chat_app/domain/exceptions/auth_exception.dart';

class LoginUseCase {
  LoginUseCase(this.authRepository, this.streamApiRepository);

  final AuthRepository authRepository;
  final StreamApiRepository streamApiRepository;

  Future<bool> validateLogin() async {
    final user = await authRepository.getAuthUser();
    if (user != null){
      final result = await streamApiRepository.connectIfExist(user.id);
      if (result) {
        return true;
      } else {
        throw AuthException(AuthErrorCode.not_chat_user);
      }
    }
    throw AuthException(AuthErrorCode.not_auth);
  }
}