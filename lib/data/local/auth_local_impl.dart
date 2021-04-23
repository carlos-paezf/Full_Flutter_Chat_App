import 'package:full_flutter_chat_app/data/auth_repository.dart';
import 'package:full_flutter_chat_app/domain/models/auth_user.dart';

class AuthLocalImpl extends AuthRepository {
  @override
  Future<AuthUser> getAuthUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser('carlos-paezf');
  }

  @override
  Future<AuthUser> signIn() async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser('carlos-paezf');
  }

  @override
  Future<void> logout() async {
    return;
  }
}