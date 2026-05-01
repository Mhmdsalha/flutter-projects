import 'package:dio/dio.dart';
import 'package:shop/shered/components/constants.dart';

class dio_helper {
  static Dio? dio;
  static Dio? search_dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/fcm/send',
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
      'content-type': 'application/json',
      'Authorization': fcmServerKey.isEmpty ? '' : 'key=$fcmServerKey'
    };
    return dio?.post(url, data: data);
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
