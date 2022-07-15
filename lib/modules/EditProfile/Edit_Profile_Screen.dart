import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/styles/icons_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  File? image;
  var picker = ImagePicker();



  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileImage = SocialLayoutCubit.get(context).profileImage;
        var coverImage = SocialLayoutCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel!.bio!;
        phoneController.text = userModel!.phone!;
        return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: "Edit Profile",
                actions: [
                  defaultTextButton(
                      text: "Update",
                      fun: () {
                        SocialLayoutCubit.get(context).updateUser(
                            name: nameController.text,
                            phone: phoneController.text,
                            bio: bioController.text,
                            context: context
                        );
                      },
                      weight: FontWeight.bold)
                ]),
            body: ConditionalBuilder(
                condition: userModel != null,
                builder: (context) => SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            if (state is SocialUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 190,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Align(
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Container(
                                          height: 160,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: coverImage == null
                                                      ? NetworkImage(
                                                          "${userModel!.cover}")
                                                      : FileImage(coverImage)
                                                          as ImageProvider)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            child: IconButton(
                                                onPressed: () {
                                                  SocialLayoutCubit.get(context)
                                                      .getCoverImage();
                                                },
                                                icon: const Icon(
                                                  IconBroken.Camera,
                                                  color: Colors.white,
                                                  size: 16,
                                                )),
                                            radius: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.topCenter,
                                  ),
                                  Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        child: CircleAvatar(
                                          radius: 58,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          child: CircleAvatar(
                                            radius: 55,
                                            backgroundImage:
                                                profileImage == null
                                                    ? NetworkImage(
                                                        "${userModel!.image}")
                                                    : FileImage(profileImage)
                                                        as ImageProvider,
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        child: IconButton(
                                            onPressed: () {
                                              SocialLayoutCubit.get(context)
                                                  .getProfileImage();
                                            },
                                            icon: const Icon(
                                              IconBroken.Camera,
                                              color: Colors.white,
                                              size: 16,
                                            )),
                                        radius: 16.0,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            if (SocialLayoutCubit.get(context).profileImage !=
                                    null ||
                                SocialLayoutCubit.get(context).coverImage !=
                                    null)
                              Row(
                                children: [
                                  if (SocialLayoutCubit.get(context)
                                          .profileImage !=
                                      null)
                                    Expanded(
                                        child: Column(
                                      children: [
                                        defaultButton(
                                            fun: () {
                                              SocialLayoutCubit.get(context)
                                                  .uploadProfileImage(
                                                      name: nameController.text,
                                                      phone: phoneController.text,
                                                      bio: bioController.text,
                                                      context: context
                                              );
                                            },
                                            text: "Upload Profile",
                                            height: 45.0,
                                            TextColor: Colors.white),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        if(state is SocialUserImageUpdateLoadingState)
                                          const LinearProgressIndicator(),
                                      ],
                                    )),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  if (SocialLayoutCubit.get(context)
                                          .coverImage !=
                                      null)
                                    Expanded(
                                        child: Column(
                                      children: [
                                        defaultButton(
                                            fun: () {
                                              SocialLayoutCubit.get(context)
                                                  .uploadCoverImage(
                                                  name: nameController.text,
                                                  phone: phoneController.text,
                                                  bio: bioController.text,
                                                  context: context
                                              );
                                            },
                                            text: "Upload Cover",
                                            height: 45.0,
                                            TextColor: Colors.white),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        if(state is SocialUserCoverUpdateLoadingState)
                                          const LinearProgressIndicator(),
                                      ],
                                    )),
                                ],
                              ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            textFormField(
                                controller: nameController,
                                label: "Name",
                                type: TextInputType.name,
                                prefixIcon: IconBroken.User,
                                validation: "Name must not be empty",
                                context: context
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            textFormField(
                                controller: phoneController,
                                label: "Phone",
                                type: TextInputType.phone,
                                prefixIcon: IconBroken.Call,
                                validation: "Phone must not be empty",
                                context: context
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            textFormField(
                              controller: bioController,
                              label: "Bio",
                              type: TextInputType.text,
                              prefixIcon: IconBroken.Info_Circle,
                              context: context
                            )
                          ],
                        ),
                      ),
                    ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())));
      },
    );
  }
}
