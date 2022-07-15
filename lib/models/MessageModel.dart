class MessageModel{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;

  MessageModel({
    this.text,
    this.dateTime,
    this.receiverId,
    this.senderId
});

  MessageModel.fromJson(Map<String, dynamic> json){
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap(){
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "text": text,
      "dateTime": dateTime,

    };
  }
}