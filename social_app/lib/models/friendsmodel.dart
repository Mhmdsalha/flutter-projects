class friendsmodel {
  String? name;
  String? uid;
  String? profileimage;
  String? token;

  friendsmodel({
    this.name,
    this.uid,
    this.profileimage,
    this.token,
  });

  friendsmodel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    profileimage = json['profileimage'];
    token = json['token'];
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'uid': uid,
      'profileimage': profileimage,
      'token': token,
     
    };
  }
}
