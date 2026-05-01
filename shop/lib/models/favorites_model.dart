class favoritesmodel {
  late bool status;
  late String message;
  favoritesmodel.fromJson(Map<String, dynamic> Json1) {
    status = Json1['status'];
    message = Json1['message'];
  }
}
