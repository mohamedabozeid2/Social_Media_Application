class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}

class SocialLoginChangeVisibility extends SocialLoginStates{}

class SocialLoginSuccessState extends SocialLoginStates{
  final String uid;

  SocialLoginSuccessState(this.uid);
}

class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialLoginLoadingState extends SocialLoginStates{}