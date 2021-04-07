import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/domain/models/chart_user.dart';
import 'package:full_flutter_chat_app/navigator_utils.dart';
import 'package:full_flutter_chat_app/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:full_flutter_chat_app/ui/home/chat/selection/group_selection_view.dart';

class FriendsSelectionView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> FriendsSelectionCubit()..init()),
        BlocProvider(create: (_)=> FriendsGroupCubit())
      ],
      child: BlocBuilder<FriendsGroupCubit, bool>(builder: (context, isGroup) {
          return BlocBuilder<FriendsSelectionCubit, List<ChatUserState>>(builder: (context, snapshot) {
              final selectedUsers = context.read<FriendsSelectionCubit>().selectedUsers;
              return Scaffold(
                floatingActionButton: isGroup && selectedUsers.isNotEmpty
                ? FloatingActionButton(
                    onPressed: ()=>pushAndReplaceToPage(context, GroupSelectionView(selectedUsers))
                  )
                : null,
                body: Column(
                  children: [
                    if (isGroup)
                      Row(
                        children: [
                          BackButton(onPressed: () => context.read<FriendsGroupCubit>().changeToGroup(),),
                          Text('New group')
                        ],
                      )
                    else
                      Row(
                        children: [
                          BackButton(onPressed: (){Navigator.of(context).pop;}),
                          Text('People'),
                        ],
                      ),
                    if (!isGroup)
                      ElevatedButton(
                        child: Text('Create Group'),
                        onPressed: () => context.read<FriendsGroupCubit>().changeToGroup(),
                      )
                    else if (isGroup && selectedUsers.isEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(),
                          Text('Add a friend'),
                        ],
                      )
                    else 
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedUsers.length,
                          itemBuilder: (context, index){
                            final chatUserState = selectedUsers[index];
                            return Stack(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(),
                                    Text(chatUserState.chatUser.name),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete), 
                                  onPressed: ()=> context.read<FriendsSelectionCubit>().selectedUser(chatUserState),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.length,
                        itemBuilder: (context, index){
                          final chatUserState = snapshot[index];
                          return ListTile(
                            onTap: (){
                              print('Selected User');
                            },
                            leading: CircleAvatar(),
                            title: Text(chatUserState.chatUser.name),
                            trailing: isGroup
                              ? Checkbox(value: chatUserState.selected, 
                                onChanged: (val){
                                  context.read<FriendsSelectionCubit>().selectedUser(chatUserState);
                                  print('Selected user for group');
                                })
                              : null,
                          );
                        },
                      )
                    )
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }
}