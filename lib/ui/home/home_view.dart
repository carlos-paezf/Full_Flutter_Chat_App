import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/ui/home/chat/chat_view.dart';
import 'package:full_flutter_chat_app/ui/home/chat/selection/friends_selection_view.dart';
import 'package:full_flutter_chat_app/ui/home/home_view_cubit.dart';
import 'package:full_flutter_chat_app/ui/home/settings/settings_view.dart';
import 'package:full_flutter_chat_app/navigator_utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(_) => HomeViewCubit(),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<HomeViewCubit, int>(
              builder: (context, snapshot) {
                return IndexedStack(
                  index: snapshot,
                  children: [
                    ChatView(),
                    SettingsView(),
                  ],
                );
              }
            ),
          ),
          HomeNavigationBar(),
        ],
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: ()=>context.read<HomeViewCubit>().onChangeTab(0), child: Text('Chats')),
          FloatingActionButton(
            onPressed: (){
              pushToPage(context, FriendsSelectionView());
            },
            child: Icon(Icons.add),
          ),
          ElevatedButton(onPressed: ()=>context.read<HomeViewCubit>().onChangeTab(1), child: Text('Settings')),
        ],
      ),
    );
  }
}