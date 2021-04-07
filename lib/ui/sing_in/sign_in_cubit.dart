import 'package:flutter_bloc/flutter_bloc.dart';

enum SignInState{
  none, existing
}

class SignInCubit extends Cubit<SignInState>{
  SignInCubit() : super(SignInState.none);

  void signIn() async {
    //TODO: Validate with services
    await Future.delayed(const Duration(seconds: 2));
    emit(SignInState.none);
  }

}