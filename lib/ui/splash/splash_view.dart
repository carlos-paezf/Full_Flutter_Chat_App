import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/navigator_utils.dart';
import 'package:full_flutter_chat_app/ui/home/home_view.dart';
import 'package:full_flutter_chat_app/ui/profile_verify/profile_verify_view.dart';
import 'package:full_flutter_chat_app/ui/sing_in/sign_in_view.dart';
import 'package:full_flutter_chat_app/ui/splash/splash_cubit.dart';


class SplashView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, snapshot) {
          if (snapshot == SplashState.none){
            pushAndReplaceToPage(context, SignInView());
          } else if (snapshot == SplashState.existing_user){
            pushAndReplaceToPage(context, HomeView());
          } else {
            pushAndReplaceToPage(context, ProfileVerifyView());
          }
        },
        child: Scaffold(
            backgroundColor: Colors.red,
          ),
      ),
    );
  }
}