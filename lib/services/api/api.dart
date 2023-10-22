import 'package:dio/dio.dart';
import 'package:rick_and_morty/services/api/api_interceptors.dart';
import 'package:rick_and_morty/services/api/api_list.dart';

class AppApi {
  static Dio get defaultApiClient => AppApiClientBuilder()
      .ofUrl(baseUrl)
      .setDefaultHeader()
      .addInterceptor(CheckNetworkInterceptor())
      .addInterceptor(ErrorInterceptor())
      .create();

  // static Dio get authenticatorApiClient => defaultApiClient
  //     .newBuilder()
  //     .addInterceptor(AuthRequestInterceptor())
  //     .create();
}

class AppApiClientBuilder {
  static const Duration defaultTimeout = Duration(seconds: 30);

  Dio dio = Dio(BaseOptions(
      connectTimeout: defaultTimeout,
      receiveTimeout: defaultTimeout,
      sendTimeout: defaultTimeout));

  AppApiClientBuilder addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
    return this;
  }

  AppApiClientBuilder ofUrl(String url) {
    dio.options.baseUrl = url;
    return this;
  }

  AppApiClientBuilder setTimeout(Duration timeout) {
    dio.options.connectTimeout = timeout;
    dio.options.sendTimeout = timeout;
    dio.options.receiveTimeout = timeout;
    return this;
  }

  AppApiClientBuilder setDefaultHeader() {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'application/json';

    return this;
  }

  Dio create() {
    // HttpClient client = new HttpClient();
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    return dio;
  }
}

extension Builder on Dio {
  AppApiClientBuilder newBuilder() {
    AppApiClientBuilder builder = AppApiClientBuilder();
    builder.dio = this;
    return builder;
  }
}
