class CommentModel {
  String? comment;
  String? profileImage;
  String? userId;
  String? date;
  String? name;

  CommentModel(this.comment, this.profileImage, this.userId, this.name, this.date);

  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['text'];
    profileImage = json['profileImage'];
    userId = json['userId'];
    name = json['name'];
    date = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': comment,
      'profileImage': profileImage,
      'userId': userId,
      'name': name,
      'date': date,
    };
  }
}
