import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/New_Post/New_Post_Screen.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/styles/icons_broken.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('FROM SOCIAL LAYOUT SCREEN');
    var cubit = SocialLayoutCubit.get(context);
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {
                  SocialLayoutCubit.get(context).getPosts();
                },
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
              IconButton(
                onPressed: () {
                  cubit.signOut(context);
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBotNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: "Post"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: "Users"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: "Settings"),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          // body: NestedScrollView(
          //   floatHeaderSlivers: true,
          //   headerSliverBuilder: (context, innerBoxIsScroller){
          //     return [
          //       SliverAppBar(
          //       floating: true,
          //       // snap: true,
          //       expandedHeight: 240,
          //       flexibleSpace: FlexibleSpaceBar(
          //         background: Image.network(userModel!.image!, fit: BoxFit.cover,alignment: Alignment.topCenter),
          //         title: Text(cubit.titles[cubit.currentIndex]),
          //       ),
          //     )];
          //   },
          //     body: cubit.screens[cubit.currentIndex],
          //
          // ),
        );
      },
    );
  }
}
