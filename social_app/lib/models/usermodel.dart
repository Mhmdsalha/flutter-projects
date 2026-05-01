class usermodel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? profilephoto;
  String? cover;
  String? bio;
  int? posts;
  String? token;
  late bool isEmailVerified;

  usermodel(
      {this.name,
      this.email,
      this.phone,
      this.uid,
      this.profilephoto,
      this.cover,
      this.bio,
      this.token,
      required this.isEmailVerified});

  usermodel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profilephoto = json['profilephoto'];
    cover = json['cover'];
    uid = json['uid'];
    bio = json['bio'];
    posts = json['posts'];
    isEmailVerified = json['isEmailVerified'];
    token = json['token'];
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'profilephoto': profilephoto,
      'cover': cover,
      'bio': bio,
      'posts': posts,
      'token': token,
      'isEmailVerified': isEmailVerified
    };
  }
}
