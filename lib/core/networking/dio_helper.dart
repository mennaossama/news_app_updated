import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app_updated/core/networking/api_endpoints.dart';

class DioHelper {
  static Dio? dio;
  static initDio() {
    dio ??= Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static getRequest(
      {required String endpoint,
      required Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await dio!.get(endpoint, queryParameters: queryParameters);
      return response;
    } catch (error) {
      log(error.toString());
    }
  }
}
