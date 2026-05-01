class categorymodel {
  late bool status;
  late categorydata data;

  categorymodel.fromJson(Map<String, dynamic> Json1) {
    status = Json1['status'];
    data = categorydata.fromJson(Json1['data']);
  }
}

class categorydata {
  late int currentpage;
  List<data_model> datalist = [];

  categorydata.fromJson(Map<String, dynamic> Json2) {
    currentpage = Json2['current_page'];
    Json2['data'].forEach((element) {
      datalist.add(data_model.fromJson(element));
    });
  }
}

class data_model {
  int? id;
  String? name;
  String? image;

  data_model.fromJson(Map<String, dynamic> Json2) {
    id = Json2['id'];
    name = Json2['name'];
    image = Json2['image'];
  }
}
