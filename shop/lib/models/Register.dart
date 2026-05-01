class register_model {
  bool? status;
  String? message;
  Data? data;

  register_model({this.status, this.message, this.data});

  register_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;

  Data({this.name, this.email, this.phone, this.id, this.image, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
