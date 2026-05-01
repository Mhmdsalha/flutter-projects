import 'package:dio/dio.dart';

class dio_helper {
  static Dio? dio;
  static Dio? search_dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getdata(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(url, queryParameters: query);
  }
}
