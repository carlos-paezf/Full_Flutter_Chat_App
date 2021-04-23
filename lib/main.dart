import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_flutter_chat_app/dependencies.dart';
import 'package:full_flutter_chat_app/ui/app_theme_cubit.dart';
import 'package:full_flutter_chat_app/ui/splash/splash_view.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _streamChatClient = StreamChatClient(
    'az5jhnxcfr3q',
    //? 'c2rynysx9x6b',
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiRepositoryProvider(
      providers: buildRepositories(_streamChatClient), 
      child: BlocProvider(
        create: (context) => AppThemeCubit(context.read())..init(),
        child: BlocBuilder<AppThemeCubit, bool>(builder: (context, snapshot) {
            return MaterialApp(
              title: 'Chat App',
              home: SplashView(),
              theme: snapshot ? ThemeData.dark() : ThemeData.light(),
              builder: (context, child){
                return StreamChat(child: child, client: _streamChatClient);
              },
            );
          }
        ),
      ),
    );
  }
}
