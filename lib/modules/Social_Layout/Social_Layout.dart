import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/New_Post/New_Post_Screen.dart';
import 'package:social_application4/modules/Social_Layout/Home.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialLayoutCubit()..getUserData(userID: uId)..getPosts(),
        child: BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
          listener: (context, state){
            if(state is SocialNewPostState){
              navigateTo(context, NewPostScreen());
            }
          },
          builder: (context, state){
            return Home();
          },
        ),
    );
  }
}
