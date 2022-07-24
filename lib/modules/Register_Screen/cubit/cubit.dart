import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/models/Social_User_Model.dart';
import 'package:social_application4/modules/Register_Screen/cubit/states.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialInitialRegisterState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData icon = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    emit(SocialRegisterChangeVisibility());
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
    required BuildContext context,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: password)
        .then((value) {
      print(value.user!.email);
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
          context: context);
    }).catchError((error) {
      print("Error: ${error.toString()}");
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required BuildContext context,
  }) {
    SocialUserModel model = SocialUserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        bio: "Write your bio ...",
        image: "https://img.freepik.com/free-photo/handsome-man-isolated-yellow_1368-109064.jpg?w=996",
        cover: "https://img.freepik.com/free-photo/three-young-excited-men-jumping-together_171337-36887.jpg?w=996",
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      SocialLayoutCubit.get(context).getUserData(userID: uId);
      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}
