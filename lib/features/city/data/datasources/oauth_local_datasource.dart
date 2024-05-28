import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _amadeusAccessTokenKey = 'amadeus_access_token';

abstract interface class OAuthLocalDataSource {
  Future<String?> get accessToken;

  Future<void> saveAccessToken(String accessToken);
}

class AmadeusOAuthLocalDataSource implements OAuthLocalDataSource {
  final FlutterSecureStorage _flutterSecureStorage;

  AmadeusOAuthLocalDataSource({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  @override
  Future<String?> get accessToken => _flutterSecureStorage.read(key: _amadeusAccessTokenKey);

  @override
  Future<void> saveAccessToken(String accessToken) {
    return _flutterSecureStorage.write(key: _amadeusAccessTokenKey, value: accessToken);
  }
}
