import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_application4/models/PostModel.dart';
import 'package:social_application4/models/Social_User_Model.dart';
import 'package:social_application4/modules/Chats/Chats_Screen.dart';
import 'package:social_application4/modules/EditProfile/Edit_Profile_Screen.dart';
import 'package:social_application4/modules/Feeds/Feeds_Screen.dart';
import 'package:social_application4/modules/New_Post/New_Post_Screen.dart';
import 'package:social_application4/modules/Settings/Settings_Screen.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/modules/Users/UsersScreen.dart';
import 'package:social_application4/modules/login_screen/login_screen.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/shared/network/local/cache_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialLayoutCubit extends Cubit<SocialLayoutStates> {
  SocialLayoutCubit() : super(SocialLayoutInitialState());

  static SocialLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ["Home", "Chats", "Post", "Users", "Settings"];
  int currentIndex = 0;

  void changeBotNavBar(index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialLayoutChangeNavBotState());
    }
  }

  void signOut(context) {
    CacheHelper.removeData(key: 'uId');
    uId = CacheHelper.getData(key: 'uId');
    navigateAndFinish(context: context, widget: SocialLoginScreen());
    emit(SocialLayoutSignOutState());
  }

  // SocialUserModel? userModel;

  void getUserData() {
    emit(SocialLayoutGetUserDataLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      print("From Method Data is: ${value.data()}");
      userModel = SocialUserModel.fromJson(value.data()!);

      emit(SocialLayoutGetUserDataSuccessState());
    }).catchError((error) {
      print("Error ===> ${error.toString()}");
      emit(SocialLayoutGetUserDataErrorState());
    });
  }

  void navigateToEditPage(context) {
    navigateTo(context, EditProfileScreen());
    emit(SocialNavigationState());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialCoverImagePickedErrorState());
    }
  }

  // String profileImageUrl = '';

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserImageUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      print("Profile image uploaded successfully");
      value.ref.getDownloadURL().then((value) {
        // profileImageUrl = value;
        updateUser(name: name, phone: phone, bio: bio, image: value);
        profileImage = null;
        emit(SocialUploadProfileImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print("Error while upload profile image ===> ${error.toString()}");
    });
  }

  // String coverImageUrl = '';
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserCoverUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      print("Cover image uploaded successfully");
      value.ref.getDownloadURL().then((value) {
        // coverImageUrl = value;
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        coverImage = null;
        emit(SocialUploadCoverImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
      print("Error while upload Cover image ===> ${error.toString()}");
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    if (cover == null && image == null) {
      emit(SocialUserUpdateLoadingState());
    }
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      uId: userModel!.uId,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print("Error while update user data ===> ${error.toString()}");
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      print("Cover image uploaded successfully");
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
        postImage = null;
        emit(SocialCreatePostSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
      print("Error while upload Cover image ===> ${error.toString()}");
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? "",
    );
    emit(SocialCreatePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      getPosts();
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print("Error while update user data ===> ${error.toString()}");
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<Map<String, String>> userLikes = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((gotPosts) {
      gotPosts.docs.forEach((postDocs) {
        postDocs.reference.collection('likes').get().then((likeDocs) {
          getLike(postDocs.id);
          likes.add(likeDocs.docs.length);
          // print("-----$likes");
          postsId.add(postDocs.id);
          posts.add(PostModel.fromJson(postDocs.data()));
          // print(userLikes);
          emit(SocialLayoutGetPostDataSuccessState());
        }).catchError((error) {});
      });
    }).catchError((error) {
      emit(SocialLayoutGetPostDataErrorState(error.toString()));
    });
  }


  List<String> colorIcons = [];

  void getLike(String postId){
    emit(SocialGetLikeLoadingState());
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(userModel!.uId).get().then((value){
      if(value.data() != null){
        colorIcons.add('red');
      }else{
        colorIcons.add('grey');
      }
      emit(SocialGetLikeSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(SocialGetLikeErrorState());
    });
  }

  // void finalGetLikes() {
  //   for (int i = 0; i < posts.length; i++) {
  //     FirebaseFirestore.instance
  //         .collection('posts')
  //         .doc(postsId[i])
  //         .collection('likes')
  //         .get()
  //         .then((value) {
  //       for (var element in value.docs) {
  //         if (element.id == userModel!.uId) {
  //           colorIcons.add('red');
  //           break;
  //         } else {
  //           // colorIcons.add('grey');
  //         }
  //       }
  //     });
  //   }
  //   print(colorIcons);
  // }


  //
  // void getLikes(index) {
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postsId[index])
  //       .collection('likes')
  //       .get()
  //       .then((value) {
  //     print("HEREEE");
  //     for (var element in value.docs) {
  //       if (userModel!.uId == element.id) {
  //         likeUserId.add(element.id);
  //         print("YES");
  //         break;
  //       } else {
  //         print("NO");
  //       }
  //     }
  //   }).catchError((error) {
  //     print(error);
  //   });
  // }
  //
  // void getAllLikes() {
  //   FirebaseFirestore.instance.collection('posts').get().then((value) {
  //     value.docs.forEach((element) {
  //       element.reference.collection('likes').get().then((value) {
  //         value.docs.forEach((element) {
  //           print(element.id);
  //         });
  //         // for(int i=0; i<posts.length; i++){
  //         //   if(posts[1].uId == )
  //         // }
  //       });
  //     });
  //   });
  // }

  // void getAllLikes(){
  //   FirebaseFirestore.instance.collection('posts').get().then((value){
  //     value.docs.forEach((element) {
  //       element.reference.collection('likes').get().then((value){
  //         // print("${postsId} ==== ${value.docs.length}");
  //         value.docs.forEach((element){
  //           print("element.id ${element.id}");
  //         });
  //       });
  //     });
  //   });
  // }

  // void getLikes2(index) {
  //   FirebaseFirestore.instance.collection('posts').doc(postsId[index])
  //       .collection('likes').get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       likeUserId.add(element.id);
  //       print(element.id);
  //     });
  //   });
  // }

  void likePost(String postId, index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }

  void disLikePost(String postId, index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      emit(SocialDisLikePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialDisLikePostErrorState());
    });
  }

  void checkLike(int index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId[index])
        .collection('likes')
        .doc(userModel!.uId)
        .get()
        .then((value) {
      if (value.data() == null) {
        likes[index]++;
        print('ADD');
        print(likes[index]);
        likePost(postsId[index], index);
      } else {
        likes[index]--;
        print('remove add');
        print(likes[index]);
        disLikePost(postsId[index], index);
      }
      // getLikes(index);
    });
  }
}
