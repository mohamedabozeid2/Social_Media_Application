class SocialLayoutStates{}

class SocialLayoutInitialState extends SocialLayoutStates{}

class SocialLayoutGetUserDataLoadingState extends SocialLayoutStates{}
class SocialLayoutGetUserDataSuccessState extends SocialLayoutStates{}
class SocialLayoutGetUserDataErrorState extends SocialLayoutStates{}

class SocialLayoutSignOutState extends SocialLayoutStates{}

class SocialLayoutChangeNavBotState extends SocialLayoutStates{}

class SocialNewPostState extends SocialLayoutStates{}

class SocialNavigationState extends SocialLayoutStates{}

class SocialProfileImagePickedSuccessState extends SocialLayoutStates{}
class SocialProfileImagePickedErrorState extends SocialLayoutStates{}

class SocialUploadProfileImageSuccessState extends SocialLayoutStates{}
class SocialUploadProfileImageErrorState extends SocialLayoutStates{}

class SocialCoverImagePickedSuccessState extends SocialLayoutStates{}
class SocialCoverImagePickedErrorState extends SocialLayoutStates{}

class SocialUploadCoverImageSuccessState extends SocialLayoutStates{}
class SocialUploadCoverImageErrorState extends SocialLayoutStates{}

class SocialUserUpdateErrorState extends SocialLayoutStates{}
class SocialUserUpdateLoadingState extends SocialLayoutStates{}

class SocialUserImageUpdateLoadingState extends SocialLayoutStates{}
class SocialUserCoverUpdateLoadingState extends SocialLayoutStates{}

//create post

class SocialCreatePostLoadingState extends SocialLayoutStates{}
class SocialCreatePostSuccessState extends SocialLayoutStates{}
class SocialCreatePostErrorState extends SocialLayoutStates{}

class SocialDeletePostLoadingState extends SocialLayoutStates{}
class SocialDeletePostSuccessState extends SocialLayoutStates{}
class SocialDeletePostErrorState extends SocialLayoutStates{}

class SocialPostImagePickedSuccessState extends SocialLayoutStates{}
class SocialPostImagePickedErrorState extends SocialLayoutStates{}
class SocialRemovePostImageState extends SocialLayoutStates{}

// GetPosts

class SocialLayoutGetPostDataLoadingState extends SocialLayoutStates{}
class SocialLayoutGetPostDataSuccessState extends SocialLayoutStates{}
class SocialLayoutGetPostDataErrorState extends SocialLayoutStates{
  final String error;

  SocialLayoutGetPostDataErrorState(this.error);
}

class SocialLikePostLoadingState extends SocialLayoutStates{}
class SocialLikePostSuccessState extends SocialLayoutStates{}
class SocialLikePostErrorState extends SocialLayoutStates{}


class SocialDisLikePostLoadingState extends SocialLayoutStates{}
class SocialDisLikePostSuccessState extends SocialLayoutStates{}
class SocialDisLikePostErrorState extends SocialLayoutStates{}

class SocialGetLikeLoadingState extends SocialLayoutStates{}
class SocialGetLikeSuccessState extends SocialLayoutStates{}
class SocialGetLikeErrorState extends SocialLayoutStates{}

class SocialGetLikeUsersIdLoadingState extends SocialLayoutStates{}
class SocialGetLikeUsersIdSuccessState extends SocialLayoutStates{}
class SocialGetLikeUsersIdErrorState extends SocialLayoutStates{}

class SocialAddCommentLoadingState extends SocialLayoutStates{}
class SocialAddCommentSuccessState extends SocialLayoutStates{}
class SocialAddCommentErrorState extends SocialLayoutStates{}

class SocialCommentImagePickedSuccessState extends SocialLayoutStates{}
class SocialCommentImagePickedErrorState extends SocialLayoutStates{}
class SocialRemoveCommentImageState extends SocialLayoutStates{}

class SocialGetCommentsLoadingState extends SocialLayoutStates{}
class SocialGetCommentsSuccessState extends SocialLayoutStates{}
class SocialGetCommentsErrorState extends SocialLayoutStates{}


// Chat States
class SocialGetAllUserDataLoadingState extends SocialLayoutStates{}
class SocialGetAllUserDataSuccessState extends SocialLayoutStates{}
class SocialGetAllUserDataErrorState extends SocialLayoutStates{}

// Send And Get Messages
class SocialSendMessagesSuccessState extends SocialLayoutStates{}
class SocialSendMessagesErrorState extends SocialLayoutStates{}
class SocialGetMessagesLoadingState extends SocialLayoutStates{}
class SocialGetMessagesSuccessState extends SocialLayoutStates{}


