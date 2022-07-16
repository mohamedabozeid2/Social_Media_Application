import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/models/PostModel.dart';
import 'package:social_application4/modules/Feeds/Feeds_Screen.dart';
import 'package:social_application4/modules/Social_Layout/Home.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/styles/icons_broken.dart';

class NewPostScreen extends StatelessWidget {
  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("HEY");
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState) {
          postController.text = "";
          SocialLayoutCubit.get(context).postImage = null;
          navigateAndFinish(context: context, widget: Home());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Create Post", actions: [
            defaultTextButton(
                text: "Post",
                fun: () {
                  if (SocialLayoutCubit.get(context).postImage == null) {
                    SocialLayoutCubit.get(context).createPost(
                        dateTime: DateTime.now().toString(),
                        text: postController.text);
                  } else {
                    SocialLayoutCubit.get(context).uploadPostImage(
                        dateTime: DateTime.now().toString(),
                        text: postController.text);
                  };
                })
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "${userModel!.image}"),
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
                                "${userModel!.name}",
                                style: const TextStyle(
                                  height: 1.0,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                          Text(
                            "Public",
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                        hintText: "What is on your mind, ${userModel!.name} ?",
                        border: InputBorder.none),
                  ),
                ),
                if (SocialLayoutCubit.get(context).postImage != null)
                  const SizedBox(
                    height: 20.0,
                  ),
                if (SocialLayoutCubit.get(context).postImage != null)
                  Stack(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                                image: DecorationImage(
                                    image: FileImage(
                                        SocialLayoutCubit.get(context)
                                            .postImage!) as ImageProvider)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 16,
                              child: IconButton(
                                  onPressed: () {
                                    SocialLayoutCubit.get(context)
                                        .removePostImage();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 16,
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
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialLayoutCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text("add photo")
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "#",
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                            Text(
                              "tags"
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
