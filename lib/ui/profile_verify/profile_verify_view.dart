import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/navigator_utils.dart';
import 'package:full_flutter_chat_app/ui/home/home_view.dart';
import 'package:full_flutter_chat_app/ui/profile_verify/profile_verify_cubit.dart';


class ProfileVerifyView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileVerifyCubit(context.read(), context.read()),
      child: BlocConsumer<ProfileVerifyCubit, ProfileState>(
        listener: (context, snapshot){
          if(snapshot.success){
            pushAndReplaceToPage(context, HomeView());
          }
        },
        builder: (context, snapshot){
          // Refresh the photo
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Verify you identity'),
                  if (snapshot.file != null) Image.file(snapshot.file, height: 200)
                  else Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  ),
                  IconButton(
                    icon: Icon(Icons.photo), 
                    onPressed: () => context.read<ProfileVerifyCubit>().pickImage(),
                  ),
                  Text('Your name'),
                  TextField(
                    controller: context.read<ProfileVerifyCubit>().nameController,
                    decoration: InputDecoration(
                      hintText: 'Or just how people now you'
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Start chatting now'),
                    onPressed: () => context.read<ProfileVerifyCubit>().startChatting(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}