import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/models/PostModel.dart';
import 'package:social_application4/modules/CommentScreen/CommentTextField.dart';
import 'package:social_application4/modules/Feeds/CommentButton.dart';
import 'package:social_application4/modules/Feeds/LikeButton.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/styles/icons_broken.dart';
import 'package:social_application4/styles/themes.dart';

class FeedsScreen extends StatefulWidget {
  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {

  void initState(){

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if (state is SocialLayoutGetPostDataLoadingState || userModel == null || state is SocialLayoutGetUserDataLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    child: Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: const [
                        Image(
                            height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://img.freepik.com/free-photo/horizontal-shot-happy-adult-man-points-index-finger-away-shows-advertisement-against-yellow-studio-background-wears-round-spectacles-casual-t-shirt-demonstrates-promo-look-this-please_273609-59011.jpg?w=1060",
                            )),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Communicate \n with friends",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Jannah",
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        posts[index],
                        context,
                        index,
                        state
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: posts.length)
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildPostItem(PostModel model, BuildContext context, index, state) {
    var commentController = TextEditingController();
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
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
                              "${model.name}",
                              style: const TextStyle(
                                height: 1.0,
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultBlueColor,
                              size: 16.0,
                            ),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                        Text(
                          "${model.dateTime}",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 18.0,
                      )),
                ],
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 2,
              ),
              Text(
                "${model.text}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10.0),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text("#Software",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.blue,
                                      ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10.0),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text("#Mobile_Developement",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.blue,
                                      ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10.0),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text("#Flutter",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.blue,
                                      ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5.0),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text("#Software_Developer",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.blue,
                                      ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.postImage != "")
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: 150.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("${model.postImage}"))),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: LikeButton(
                      index: index,
                      likesNumber: likes[index],
                      fun: () {
                        SocialLayoutCubit.get(context).checkLike(index);
                      },
                      colorIcons: colorIcons,
                    ),
                  ),
                  Expanded(
                    child: CommentButton(
                        index: index,
                        comment: state is SocialAddCommentLoadingState ? "loading" : "${commentsNumber[index]} comments" ,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 2,
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        InkWell(
                          child: CircleAvatar(
                            radius: 18.0,
                            backgroundImage:
                                NetworkImage("${userModel!.image}"),
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        CommentTextField(
                          controller: commentController,
                        ),
                      ],
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                const Icon(
                                  IconBroken.Chat,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "send",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if(commentController.text.isNotEmpty){
                                SocialLayoutCubit.get(context)
                                    .addComment(
                                    text: commentController.text,
                                    index: index,
                                    postId: postsId[index]);
                                print(commentController.text);
                                commentController.text = '';
                              }
                           });
                          },
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                const Icon(
                                  IconBroken.Send,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "share",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
