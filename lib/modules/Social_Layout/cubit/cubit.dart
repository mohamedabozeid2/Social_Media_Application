import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
        updateUser(name: name, phone: phone, bio: bio,image: value);
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

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {}
  //   if (coverImage == null && profileImage == null) {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    if(cover ==null && image == null){
      emit(SocialUserUpdateLoadingState());
    }
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      uId: userModel!.uId,
      cover: cover??userModel!.cover,
      image: image??userModel!.image,
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
}
