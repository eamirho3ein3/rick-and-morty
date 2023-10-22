import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/services/api/check_internet_conection.dart';

class CheckNetworkInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var conectionStatus = await checkInternetConenction();
    if (conectionStatus) {
      log("conectionStatus = ${options.uri}");
      log("conection queryParameters = ${options.queryParameters}");
      return handler.next(options);
    } else {
      var error = getInternetConectionError(options: options);
      return handler.reject(error, false);
    }
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("err statusCode = ${err.response?.statusCode}");
    print("err type = ${err.type}");
    print("err type = $err");
    print("message = ${err.message}");

    // if (err.response?.statusCode == 401) {
    //   var response = await _retryAuthorization(err);
    //   if (response != null && response.statusCode == 200) {
    //     return handler.resolve(response);
    //   }
    // }

    return handler.next(err);
  }
}

DioException getInternetConectionError({required RequestOptions options}) {
  return DioException(
    requestOptions: options,
    error: 'اینترنت قطع می باشد',
    type: DioExceptionType.connectionTimeout,
  );
}
