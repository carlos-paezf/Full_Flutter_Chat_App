import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState{
  none, existing_user, new_user
}

class SplashCubit extends Cubit<SplashState>{
  SplashCubit() : super(SplashState.none);

  void init() async{
    //TODO: Validate with services
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashState.existing_user);
  }
}