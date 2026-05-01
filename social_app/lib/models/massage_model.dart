import 'package:cloud_firestore/cloud_firestore.dart';

class massage_model {
  String? massageText;
  String? replayedmassageText;
  String? senderId;
  String? receiverId;
  String? token;
  FieldValue? DateTimemessage;
  String? image;

  massage_model(
      {this.massageText,
      this.senderId,
      this.receiverId,
      this.token,
      this.DateTimemessage,
      this.replayedmassageText,
      this.image});

  massage_model.fromJson(Map<String, dynamic> json) {
    massageText = json['massageText'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    token = json['token'];
    image = json['image'];
    replayedmassageText = json['replayedmassageText'];
  }

  Map<String, dynamic> tomap() {
    return {
      'massageText': massageText,
      'senderId': senderId,
      'receiverId': receiverId,
      'token': token,
      'DateTimemessage': DateTimemessage,
      'image': image,
      'replayedmassageText': replayedmassageText,
    };
  }
}
