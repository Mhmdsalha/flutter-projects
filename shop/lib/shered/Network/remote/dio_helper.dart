import 'package:dio/dio.dart';

class dio_helper {
  static Dio? dio;
  static Dio? search_dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getdata({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String? lang,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response>? postdata({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
    String? lang,
  }) {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return dio?.post(url, queryParameters: query, data: data);
  }

  static Future<Response>? putdata(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token,
      String? lang}) {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return dio?.put(url, queryParameters: query, data: data);
  }
}
