import 'package:cloud_firestore/cloud_firestore.dart';

class notifications_model {
  String? title;
  String? receivername;
  String? sendername;
  String? senderuid;
  String? receiveruid;
  String? token;
  String? body;
  String? senderprofileimage;
  String? receiverprofileimage;
  Timestamp? notificationsDateTime;
  bool? friendsRequest;

  notifications_model.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    senderprofileimage = json['senderprofileimage'];
    receiverprofileimage = json['receiverprofileimage'];
    notificationsDateTime = json['notificationsDateTime'];
    friendsRequest = json['friendsRequest'];
    senderuid = json['senderuid'];
    receiveruid = json['receiveruid'];
    receivername = json['receivername'];
    sendername = json['sendername'];
    token = json['token'];
  }

  notifications_model({
    this.title,
    this.body,
    this.receiverprofileimage,
    this.senderprofileimage,
    this.notificationsDateTime,
    this.friendsRequest,
    this.receiveruid,
    this.senderuid,
    this.sendername,
    this.receivername,
    this.token,
  });

  Map<String, dynamic> tomap() {
    return {
      'title': title,
      'body': body,
      'receiverprofileimage': receiverprofileimage,
      'senderprofileimage': senderprofileimage,
      'notificationsDateTime': notificationsDateTime,
      'friendsRequest': friendsRequest,
      'senderuid': senderuid,
      'receiveruid': receiveruid,
      'receivername': receivername,
      'sendername': sendername,
      'token': token,
    };
  }
}
