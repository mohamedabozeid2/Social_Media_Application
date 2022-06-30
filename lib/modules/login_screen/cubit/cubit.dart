import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/login_screen/cubit/states.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/shared/network/local/cache_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData icon = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    emit(SocialLoginChangeVisibility());
  }

  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: password)
        .then((value) {
          if(!FirebaseAuth.instance.currentUser!.emailVerified){
              FirebaseAuth.instance.currentUser!.sendEmailVerification();
          }
          CacheHelper.saveData(key: 'uId', value: value.user!.uid);
          uId = CacheHelper.getData(key: 'uId');
      SocialLayoutCubit.get(context).getUserData();
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print("Error from Login===> ${error.toString()}");
      emit(SocialLoginErrorState(error.toString()));
    });
  }
}
