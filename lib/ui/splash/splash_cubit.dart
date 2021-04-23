import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/domain/exceptions/auth_exception.dart';
import 'package:full_flutter_chat_app/domain/usecases/login_usecase.dart';

enum SplashState{
  none, existing_user, new_user
}

class SplashCubit extends Cubit<SplashState>{
  SplashCubit(this._loginUseCase) : super(SplashState.none);

  final LoginUseCase _loginUseCase;

  void init() async{
    try {
      final result = await _loginUseCase.validateLogin();
      if (result) {
        emit(SplashState.existing_user);
      }
    } on AuthException catch (e) {
      if (e.error == AuthErrorCode.not_auth){
        emit(SplashState.none);
      } else {
        emit(SplashState.new_user);
      }
    }
    emit(SplashState.existing_user);
  }
}