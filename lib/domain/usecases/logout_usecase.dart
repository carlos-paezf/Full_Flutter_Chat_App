import 'package:full_flutter_chat_app/data/auth_repository.dart';
import 'package:full_flutter_chat_app/data/stream_api_respository.dart';

class LogoutUseCase {
  LogoutUseCase(this.streamApiRepository, this.authRepository);

  final StreamApiRepository streamApiRepository;
  final AuthRepository authRepository;

  Future<void> logout() async {
    await streamApiRepository.logout();
    await authRepository.logout();
  }
}