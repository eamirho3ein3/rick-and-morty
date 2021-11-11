import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );

  Future<Response> get(
      {@required BuildContext context,
      Map<String, dynamic> queryParameters}) async {
    Response response;
    try {
      response = await _dio.get('/character', queryParameters: queryParameters);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
      } else {
        print('Network Error');
        print(e.message);
      }
    }
    return response;
  }
}
