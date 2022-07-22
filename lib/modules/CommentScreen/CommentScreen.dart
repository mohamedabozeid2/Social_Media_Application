import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/CommentScreen/CommentItem.dart';
import 'package:social_application4/modules/CommentScreen/CommentTextField.dart';
import 'package:social_application4/modules/Feeds/LikeButton.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/styles/icons_broken.dart';

class CommentScreen extends StatefulWidget {
  String postId;
  int index;

  CommentScreen({required this.index, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  void initState() {
    SocialLayoutCubit.get(context).getPostComments(postId: widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    index = widget.postId;

    var commentController = TextEditingController();
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: (state is SocialAddCommentLoadingState)
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10.0,
                            ),
                            LikeButton(
                                index: widget.index,
                                likesNumber: likes[widget.index],
                                fun: () {
                                  SocialLayoutCubit.get(context)
                                      .checkLike(widget.index);
                                },
                                colorIcons: colorIcons),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    IconBroken.Chat,
                                    size: 20.0,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    (state is SocialGetCommentsLoadingState ||
                                            state
                                                is SocialAddCommentLoadingState)
                                        ? "loading"
                                        : "${commentsNumber[widget.index]} comments",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  const Icon(
                                    IconBroken.Send,
                                    color: Colors.green,
                                    size: 20.0,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '0',
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, insideIndex) {
                            return CommentItem(
                              name: postComments[insideIndex].name!,
                              profileImage:
                                  postComments[insideIndex].profileImage!,
                              comment: postComments[insideIndex].comment!,
                              date: postComments[insideIndex].date!,
                              commentImage: postComments[insideIndex].image!,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              myDivider(color: Colors.blueGrey[100]!),
                          itemCount: postComments.length),
                    ),
                    if (SocialLayoutCubit.get(context).commentImage != null)
                      const SizedBox(
                        height: 20.0,
                      ),
                    if (SocialLayoutCubit.get(context).commentImage != null)
                      Stack(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 75,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                        image: FileImage(
                                                SocialLayoutCubit.get(context)
                                                    .commentImage!)
                                            as ImageProvider)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 16,
                                  child: IconButton(
                                      onPressed: () {
                                        SocialLayoutCubit.get(context)
                                            .removeCommentImage();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                            Expanded(
                              child: CommentTextField(
                                controller: commentController,
                              ),
                            ),
                            InkWell(
                              child: const Icon(IconBroken.Image,
                                  color: Colors.green, size: 20),
                              onTap: () {
                                SocialLayoutCubit.get(context)
                                    .getCommentImage();
                              },
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  Text(
                                    "send",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  const Icon(
                                    IconBroken.Send,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  if (commentController.text.isNotEmpty) {
                                    if (SocialLayoutCubit.get(context)
                                            .commentImage !=
                                        null) {
                                      SocialLayoutCubit.get(context)
                                          .uploadCommentImage(
                                              text: commentController.text,
                                              index: widget.index,
                                              postId: widget.postId);
                                      print(commentController.text);
                                      commentController.text = "";
                                      print("WITH IMAGE");
                                    } else {
                                      SocialLayoutCubit.get(context).addComment(
                                          postId: widget.postId,
                                          index: widget.index,
                                          text: commentController.text);
                                      print(commentController.text);
                                      commentController.text = "";
                                      print("WITHOUT IMAGE");
                                    }
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
