class usermodel_update {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? profilephoto;
  String? cover;
  String? bio;
  late bool isEmailVerified;

  usermodel_update.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profilephoto = json['profilephoto'];
    cover = json['cover'];
    uid = json['id'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }
}
