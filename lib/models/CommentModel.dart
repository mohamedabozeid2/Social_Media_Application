class CommentModel {
  String? comment;
  String? profileImage;
  String? userId;
  String? date;
  String? name;
  String? image;

  CommentModel({
    required this.comment,required this.profileImage, required this.userId,required this.name,required this.date ,required this.image
});

  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['text'];
    profileImage = json['profileImage'];
    userId = json['userId'];
    name = json['name'];
    date = json['date'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': comment,
      'profileImage': profileImage,
      'userId': userId,
      'name': name,
      'date': date,
      'image': image,
    };
  }
}
