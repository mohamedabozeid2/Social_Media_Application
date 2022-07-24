import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/models/Social_User_Model.dart';
import 'package:social_application4/modules/Feeds/LikesScreen/PostLikeUsers.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/styles/icons_broken.dart';

class LikesScreen extends StatefulWidget {
  String postId;
  int likesNumber;

  LikesScreen({
    required this.likesNumber,
    required this.postId,
  });

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  void initState() {
    SocialLayoutCubit.get(context).getPostLikeUsersID(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Icon(
                  IconBroken.Heart,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text("${widget.likesNumber} Likes", style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 18,
                  color: Colors.black
                ),),



              ],
            ),
          ),
          body: state is SocialGetLikeUsersIdLoadingState
              ? const Center(child: CircularProgressIndicator())
              : Column(
                      children: [
                        Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return PostLikeUsers(model: usersOnPostLikes[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return myDivider(color: Colors.grey[300]!);
                                },
                                itemCount: usersOnPostLikes.length))
                      ],
                    )
        );
      },
    );
  }
}
