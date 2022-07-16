import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/CommentScreen/CommentScreen.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/styles/icons_broken.dart';

import '../../shared/constants/constants.dart';

class CommentButton extends StatelessWidget {
  int index;
  String comment;

  CommentButton({
    required this.index,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    IconBroken.Chat,
                    size: 20,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    comment,
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption,
                  )
                ],
              ),
            ),
            onTap: () {
              /*scaffoldKey.currentState!.showBottomSheet((context) {
                            return Container(
                              decoration:
                                  BoxDecoration(color: Colors.blueGrey[100]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          LikeButton(
                                              index: index,
                                              likesNumber:
                                                  SocialLayoutCubit.get(context)
                                                      .likes[index],
                                              fun: (){
                                                SocialLayoutCubit.get(context).checkLike(index);
                                              },
                                              colorIcons: SocialLayoutCubit.get(context).colorIcons),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                              child: Row(
                                                children: [
                                                  const Icon(IconBroken.Chat,
                                                  size: 20,
                                                  color: Colors.amber,),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text("${SocialLayoutCubit.get(context).comments[index].length}",
                                                    style: Theme.of(context).textTheme.caption,)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, insideIndex) {
                                        return CommentItem(
                                          name: SocialLayoutCubit.get(context)
                                              .comments[index][insideIndex]
                                              .name!,
                                          profileImage:
                                              SocialLayoutCubit.get(context)
                                                  .comments[index][insideIndex]
                                                  .profileImage!,
                                          comment: SocialLayoutCubit.get(context)
                                              .comments[index][insideIndex]
                                              .comment!,
                                          date: SocialLayoutCubit.get(context)
                                              .comments[index][insideIndex]
                                              .date!,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return myDivider(color: Colors.white);
                                      },
                                      itemCount: SocialLayoutCubit.get(context)
                                          .comments[index]
                                          .length,
                                    ),
                                  )
                                ],
                              ),
                            );
                          });*/
              navigateTo(context, CommentScreen(index: index,postId: postsId[index],));
            },
          );
        },
    );
  }
}
