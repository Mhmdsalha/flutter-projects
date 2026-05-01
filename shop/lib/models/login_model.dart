class login_model {
  late bool status;
  late String message;
  userdata? data;

  login_model.fromJson(Map<String, dynamic> Json1) {
    status = Json1['status'];
    message = Json1['message'];
    data = Json1['data'] != null ? userdata.fromJson(Json1['data']) : null;
  }
}

class userdata {
  int? id;
  String? name;
  String? email;
  String? image;
  int? points;
  int? credit;
  String? token;

  userdata.fromJson(Map<String, dynamic> Json2) {
    name = Json2['name'];
    id = Json2['id'];
    email = Json2['email'];
    image = Json2['image'];
    points = Json2['points'];
    credit = Json2['credit'];
    token = Json2['token'];
  }
}
