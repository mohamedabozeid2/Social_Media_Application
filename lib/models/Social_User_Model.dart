class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? bio;
  String? cover;
  String? image;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.uId,
    this.email,
    this.phone,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'cover' : cover,
      'bio' : bio,
      'isEmailVerified' : isEmailVerified,
      'image' : image,
    };
  }
}
