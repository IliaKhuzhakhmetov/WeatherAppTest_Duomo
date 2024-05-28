import 'package:dio/dio.dart';

abstract interface class DioClientFactory {
  static const defaultConnectTimeoutDuration = Duration(seconds: 15);
  static const defaultReceiveTimeoutDuration = Duration(seconds: 15);

  static Dio create(DioFactorySettings settings) {
    final dio = Dio();
    dio.options.baseUrl = settings.baseUrl;
    dio.options.connectTimeout = settings.connectTimeout;
    dio.options.receiveTimeout = settings.receiveTimeout;

    if (settings.interceptors.isNotEmpty) {
      dio.interceptors.addAll(
        [
          ...settings.interceptors,
          if (settings.enableLog) LogInterceptor(),
        ],
      );
    }

    return dio;
  }
}

class DioFactorySettings {
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final List<Interceptor> interceptors;
  final bool enableLog;

  const DioFactorySettings({
    required this.baseUrl,
    this.connectTimeout = DioClientFactory.defaultConnectTimeoutDuration,
    this.receiveTimeout = DioClientFactory.defaultReceiveTimeoutDuration,
    this.interceptors = const [],
    this.enableLog = false,
  });
}
