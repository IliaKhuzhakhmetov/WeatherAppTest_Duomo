import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:weather_test/core/constants.dart';
import 'package:weather_test/features/city/data/datasources/oauth_local_datasource.dart';

class AmadeusOAuthInterceptor extends Interceptor {
  final OAuthLocalDataSource _authLocalDataSource;
  final DotEnv _dotEnv;

  const AmadeusOAuthInterceptor({
    required OAuthLocalDataSource authLocalDataSource,
    required DotEnv dotEnv,
  })  : _authLocalDataSource = authLocalDataSource,
        _dotEnv = dotEnv;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _authLocalDataSource.accessToken;

    if (accessToken != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    } else {
      final newAccessToken = await _getAndSaveToken();

      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $newAccessToken';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newAccessToken = await _getAndSaveToken();

      final options = err.requestOptions;
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $newAccessToken';

      final cloneReq = await Dio().fetch(options);
      return handler.resolve(cloneReq);
    }
    
    return handler.next(err);
  }

  Future<String> _getAndSaveToken() async {
    final authUri = Uri.parse(Constants.amadeusOAuthBaseUrl);

    final client = await oauth2.clientCredentialsGrant(
      authUri,
      _dotEnv.env[Constants.amadeusApiKey],
      _dotEnv.env[Constants.amadeusApiSecret],
    );

    // Save token
    final accessToken = client.credentials.accessToken;
    _authLocalDataSource.saveAccessToken(accessToken);

    return accessToken;
  }
}
