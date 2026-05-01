import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/modules/updateprofile.dart';

class PostModel {
  String? name;
  String? uid;
  String? token;
  String? profilephoto;
  String? postText;
  String? postImage;
  Timestamp? postDateTime;

  PostModel({
    this.name,
    this.uid,
    this.profilephoto,
    this.postDateTime,
    this.postImage,
    this.postText,
    this.token,
  });

  updateprofileimage(String profilephoto) {
    this.profilephoto;
  }

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilephoto = json['profilephoto'];
    uid = json['uid'];
    postText = json['postText'];
    postImage = json['postImage'];
    postDateTime = json['postDateTime'];
    token = json['token'];
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'uid': uid,
      'profilephoto': profilephoto,
      'postText': postText,
      'postImage': postImage,
      'postDateTime': postDateTime,
      'token': token,
    };
  }
}
