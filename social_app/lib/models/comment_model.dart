import 'package:cloud_firestore/cloud_firestore.dart';

class comment_model {
  String? name;
  String? uid;
  String? profilephoto;
  String? commentText;
  Timestamp? commentDateTime;

  comment_model(
      {this.name,
      this.uid,
      this.profilephoto,
      this.commentText,
      this.commentDateTime});

  comment_model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilephoto = json['profilephoto'];
    uid = json['uid'];
    commentText = json['commentText'];
    commentDateTime = json['commentDateTime'];
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'uid': uid,
      'profilephoto': profilephoto,
      'commentText': commentText,
      'commentDateTime': commentDateTime,
    };
  }
}
