import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_flutter_chat_app/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:full_flutter_chat_app/ui/home/chat/selection/group_selection_cubit.dart';

class GroupSelectionView extends StatelessWidget {
  GroupSelectionView(this.selectedUsers);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupSelectionCubit(selectedUsers),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
        listener: (context, snapshot){
          //TODO: Call chat view
        },
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Verify your identity'),
                  Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  ),
                  IconButton(icon: Icon(Icons.photo), onPressed: (){}),
                  TextField(
                    controller: context.read<GroupSelectionCubit>().nameTextController,
                    decoration: InputDecoration(hintText: 'Name of the group'),),
                  Wrap(
                    children: List.generate(
                      selectedUsers.length, (index) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(),
                          Text(selectedUsers[index].chatUser.name),
                        ],
                      )
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){}, 
                    child: Text('Next'),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}