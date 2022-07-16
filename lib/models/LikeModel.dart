class LikeModel {
  bool? like;
  String? postDate;

  LikeModel(this.like, this.postDate);

  LikeModel.fromJson(Map<String, dynamic> json){
    like = json['likes'];
    postDate = json['postDate'];
  }

  Map<String, dynamic> toMap(){
    return {
      'likes' : true,
    };
  }
}
