import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_application4/models/CommentModel.dart';
import 'package:social_application4/models/MessageModel.dart';
import 'package:social_application4/models/PostModel.dart';
import 'package:social_application4/models/Social_User_Model.dart';
import 'package:social_application4/modules/Chats/Chats_Screen.dart';
import 'package:social_application4/modules/EditProfile/Edit_Profile_Screen.dart';
import 'package:social_application4/modules/Feeds/Feeds_Screen.dart';
import 'package:social_application4/modules/New_Post/New_Post_Screen.dart';
import 'package:social_application4/modules/Settings/Settings_Screen.dart';
import 'package:social_application4/modules/Social_Layout/Home.dart';
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
    required BuildContext context,
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
        updateUser(
            name: name, phone: phone, bio: bio, image: value, context: context);
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
  void uploadCoverImage(
      {required String name,
      required String phone,
      required String bio,
      required BuildContext context}) {
    emit(SocialUserCoverUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      print("Cover image uploaded successfully");
      value.ref.getDownloadURL().then((value) {
        // coverImageUrl = value;
        updateUser(
            name: name, phone: phone, bio: bio, cover: value, context: context);
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
    required BuildContext context,
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
      navigateAndFinish(context: context, widget: Home());
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

  void getPosts() {
    print("GET POSTS");
    emit(SocialLayoutGetPostDataLoadingState());
    likes = [];
    posts = [];
    postsId = [];
    commentsNumber = [];
    colorIcons = [];

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy(
          'dateTime',
          descending: true,
        )
        .get()
        .then((gotPosts) {
      for (var postDocs in gotPosts.docs) {
        postDocs.reference.collection('likes').get().then((likeDocs) {
          postDocs.reference.collection('comments').get().then((commentDocs) {
            List<CommentModel> singleComment = [];
            for (var element in commentDocs.docs) {
              singleComment.add(CommentModel.fromJson(element.data()));
            }
            commentsNumber.add(singleComment.length);
            // comments.add(singleComment);
            singleComment = [];
///////////////////////
            likes.add(likeDocs.docs.length);
            bool found = false;
            for (var element in likeDocs.docs) {
              if (userModel!.uId == element.id) {
                colorIcons.add('red');
                found = true;
              }
              if (found == true) {
                break;
              }
            }
            if (found == false) {
              colorIcons.add('grey');
            }
/////////////////
            // getLike(postDocs.id);
            /////////////////////////////////////////////////
            // FirebaseFirestore.instance
            //     .collection('posts')
            //     .doc(postId)
            //     .collection('likes')
            //     .doc(userModel!.uId)
            //     .get()
            //     .then((value) {
            //   if (value.data() != null) {
            //     colorIcons.add('red');
            //   } else {
            //     colorIcons.add('grey');
            //   }
            //   emit(SocialGetLikeSuccessState());
            // }).catchError((error) {
            //   print("Error in get Like ====> ${error.toString()}");
            //   emit(SocialGetLikeErrorState());
            // })
            ///////////////////////////////////////////
            // likes.add(likeDocs.docs.length);
            postsId.add(postDocs.id);
            posts.add(PostModel.fromJson(postDocs.data()));
            // posts.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
            if (posts.length == gotPosts.size) {
              emit(SocialLayoutGetPostDataSuccessState());
            }
          });
        }).catchError((error) {});
      }
    }).catchError((error) {
      emit(SocialLayoutGetPostDataErrorState(error.toString()));
    });
  }

  void getLike(String postId) {
    colorIcons = [];
    emit(SocialGetLikeLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .get()
        .then((value) {
      if (value.data() != null) {
        colorIcons.add('red');
      } else {
        colorIcons.add('grey');
      }
      emit(SocialGetLikeSuccessState());
    }).catchError((error) {
      print("Error in get Like ====> ${error.toString()}");
      emit(SocialGetLikeErrorState());
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
        likePost(postsId[index], index);
      } else {
        disLikePost(postsId[index], index);
      }
      // getLikes(index);
    }).catchError((error) {
      print("Error in CheckLike ====> ${error.toString()}");
    });
  }

  void likePost(String postId, index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      likes[index]++;
      colorIcons[index] = "red";
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      print("Error In LikePost ====> ${error.toString()}");
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
      likes[index]--;
      colorIcons[index] = 'grey';
      emit(SocialDisLikePostSuccessState());
    }).catchError((error) {
      print("Error in DisLike ====> ${error.toString()}");
      emit(SocialDisLikePostErrorState());
    });
  }

  File? commentImage;
  var commentPicker = ImagePicker();

  Future<void> getCommentImage() async {
    final pickedFile =
        await commentPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      commentImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCommentImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialCommentImagePickedErrorState());
    }
  }

  void removeCommentImage() {
    commentImage = null;
    emit(SocialRemoveCommentImageState());
  }


  void uploadCommentImage({
  required String text,
    required int index,
    required String postId,
}){
    emit(SocialAddCommentLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('comments/${Uri.file(commentImage!.path).pathSegments.last}').putFile(commentImage!).then((p0){
      p0.ref.getDownloadURL().then((url){
        addComment(text: text, index: index, postId: postId, imageInComment: url);
        removeCommentImage();
      });
    });
  }


  void addComment(
      {required String text,
      required int index,
      required String postId,
      String? imageInComment,
      bool fromOutside = false}) {
    print("FROM ADD COMMENTS");
    if(commentImage == null){
      emit(SocialAddCommentLoadingState());
    }
    CommentModel commentModel = CommentModel(
        image: imageInComment ?? "",
        comment: text,
        profileImage: userModel!.image,
        userId: userModel!.uId,
        name: userModel!.name,
        date: DateTime.now().toString());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId[index])
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      ///////////
      // if(commentImage != null){
      //   firebase_storage.FirebaseStorage.instance
      //       .ref()
      //       .child('comments/${Uri.file(commentImage!.path).pathSegments.last}').putFile(commentImage!).then((p0){
      //     p0.ref.getDownloadURL().then((url){
      //       print("HERE INSIDEEEEE");
      //       print(url);
      //       removeCommentImage();
      //     });
      //   });
      // }
      ////////////
      if (fromOutside == false) {
        getPostComments(postId: postId);
      }
      commentsNumber[index]++;
      if (fromOutside == true) {
        emit(SocialAddCommentSuccessState());
      }
    }).catchError((error) {
      print("Error in Add Comment =====> ${error.toString()}");
      emit(SocialAddCommentErrorState());
    });
  }

  void getPostComments({required String postId}) {
    postComments = [];
    emit(SocialGetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('date', descending: true)
        .get()
        .then((value) {
          print("FROM GET COMMENTS");
      value.docs.forEach((element) {
        postComments.add(CommentModel.fromJson(element.data()));
      });
      emit(SocialGetCommentsSuccessState());
    }).catchError((error) {
      print("ERROR FROM GET COMMENTS ${error.toString()}");
      emit(SocialGetCommentsErrorState());
    });
  }

  // void getAllComment() {
  //   print("FROM GET ALL COMMENTS");
  //   comments = [];
  //   List<CommentModel> singleComment = [];
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .orderBy(
  //         'dateTime',
  //         descending: true,
  //       )
  //       .get()
  //       .then((value) {
  //     for (var element in value.docs) {
  //       element.reference
  //           .collection('comments')
  //           .orderBy('date', descending: true)
  //           .get()
  //           .then((value) {
  //         for (var element in value.docs) {
  //           singleComment.add(CommentModel.fromJson(element.data()));
  //         }
  //         comments.add(singleComment);
  //         singleComment = [];
  //       });
  //     }
  //   }).catchError((error) {
  //     print("Error in GetAllComments ====> ${error.toString()}");
  //     emit(SocialGetCommentsErrorState());
  //   });
  // }

  void getAllUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      }
      emit(SocialGetAllUserDataSuccessState());
    }).catchError((error) {
      print("Error in GetAllUsers ====> ${error.toString()}");
      emit(SocialGetAllUserDataErrorState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
        senderId: userModel!.uId,
        text: text,
        dateTime: dateTime,
        receiverId: receiverId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      print("Error from sendMessage ====> ${error.toString()}");
      emit(SocialSendMessagesErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      print("Error from sendMessage ====> ${error.toString()}");
      emit(SocialSendMessagesErrorState());
    });
  }

  void getMessages({required String receiverId}) {
    emit(SocialGetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      print("FROM GET");
      for (var element in event.docs) {
        print(element.data());
        messages.add(MessageModel.fromJson(element.data()));
      }
      print("AFTER GET");
      emit(SocialGetMessagesSuccessState());
    });
  }

  void getAllMessages({required String receiverId}) {
    emit(SocialGetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .get()
        .then((value) {
      print("WTF");
      for (var element in value.docs) {
        print("element.id ====> ${element.id}");
      }
    });
  }
}
