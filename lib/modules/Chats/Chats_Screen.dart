import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/models/Social_User_Model.dart';
import 'package:social_application4/modules/Chats/ChatDetailsScreen.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/styles/themes.dart';

class ChatsScreen extends StatefulWidget {
  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  void initState(){
    SocialLayoutCubit.get(context).getAllUsers();

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(users.length > 0){
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return buildChatItem(users[index]);
                    },
                    separatorBuilder: (context, index) {
                      return myDivider(color: Colors.grey);
                    },
                    itemCount: users.length),
              )
            ],
          );
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildChatItem(SocialUserModel model) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage("${model.image}"),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${model.name }",
                        style: const TextStyle(
                          height: 1.0,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
      onTap: (){
        navigateTo(context, ChatDetailsScreen(receiverUserModel: model));
      },
    );
  }
}
