import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/navigator_utils.dart';
import 'package:full_flutter_chat_app/ui/app_theme_cubit.dart';
import 'package:full_flutter_chat_app/ui/home/settings/settings_view_cubit.dart';
import 'package:full_flutter_chat_app/ui/sing_in/sign_in_view.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).client.state.user;
    final image = user?.extraData['image'];
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>SettingsSwitchCubit(context.read<AppThemeCubit>().isDark)),
        BlocProvider(create: (_)=>SettingsLogoutCubit(context.read())),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              if (image != null) Image.network(image) else Placeholder(),
              BlocBuilder<SettingsSwitchCubit, bool>(
                builder: (context, snapshot) {
                  return Switch(
                    value: snapshot, 
                    onChanged: (val) {
                      context.read<SettingsSwitchCubit>().onChangeDarkMode(val);
                      context.read<AppThemeCubit>().updateTheme(val);
                    },
                  );
                }
              ),
              Builder(
                builder: (context) {
                  return BlocListener<SettingsLogoutCubit, void>(
                    listener: (context, snapshot){
                      popAllAndPush(context, SignInView());
                    },
                    child: ElevatedButton(
                      child: Text('Logout'),
                      onPressed: (){
                        context.read<SettingsLogoutCubit>().logOut();
                      },
                    ),
                  );
                }
              )
            ]
          ),
        ),
      ),
    );
  }
}