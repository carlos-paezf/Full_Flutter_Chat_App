import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_flutter_chat_app/ui/app_theme_cubit.dart';
import 'package:full_flutter_chat_app/ui/splash/splash_view.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  final _streamChatClient = StreamChatClient('d6asjn6wg6mb');

  void connectFakeUser() async {
    await _streamChatClient.disconnect();
    _streamChatClient.connectUser(User(id: 'carlos-paezf'), _streamChatClient.devToken('carlos-paezf'));
  }

  @override
  Widget build(BuildContext context) {
    connectFakeUser();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return BlocProvider(
      create: (_) => AppThemeCubit()..init(),
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
    );
  }
}
