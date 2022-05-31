class SocialRegisterStates {}

class SocialInitialRegisterState extends SocialRegisterStates{}

class SocialRegisterChangeVisibility extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates{}

class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialCreateUserSuccessState extends SocialRegisterStates{
  final String uId;

  SocialCreateUserSuccessState(this.uId);
}

class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;

  SocialCreateUserErrorState(this.error);
}

