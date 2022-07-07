class LikeModel {
  bool? like;

  LikeModel(this.like);

  LikeModel.fromJson(Map<String, dynamic> json){
    like = json['likes'];
  }

  Map<String, dynamic> toMap(){
    return {
      'likes' : true,
    };
  }
}
