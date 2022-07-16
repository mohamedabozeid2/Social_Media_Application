
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/New_Post/New_Post_Screen.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/styles/icons_broken.dart';

class SocialLayout extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLayoutCubit()/*..getAllComment(false)*/..getUserData()..getPosts(),
      child: BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
        listener: (context, state) {
          if(state is SocialNewPostState){
            navigateTo(context, NewPostScreen());
          }
        },
        builder: (context, state) {
          var cubit = SocialLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex]
              ),
              actions: [
                IconButton(onPressed: (){print(commentsNumber);}, icon: const Icon(IconBroken.Notification)),
                IconButton(onPressed: (){}, icon: const Icon(IconBroken.Search)),

              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBotNavBar(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: "Chat"),
                BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: "Post"),
                BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: "Users"),
                BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: "Settings"),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
