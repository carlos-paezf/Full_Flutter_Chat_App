import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/navigator_utils.dart';
import 'package:full_flutter_chat_app/ui/home/home_view.dart';
import 'package:full_flutter_chat_app/ui/profile_verify/profile_verify_view.dart';
import 'package:full_flutter_chat_app/ui/sing_in/sign_in_cubit.dart';


class SignInView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, snapshot){
          if (snapshot == SignInState.none){
            pushAndReplaceToPage(context, ProfileVerifyView());
          } else {
            pushAndReplaceToPage(context, HomeView());
          }
        },
        builder: (context, snapshot){
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome to Chat'),
                  ElevatedButton(
                    child: Text('Login with Google'),
                    onPressed: (){
                      context.read<SignInCubit>().signIn();
                    }, 
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}