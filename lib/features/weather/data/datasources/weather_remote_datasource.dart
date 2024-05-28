import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_test/core/constants.dart';
import 'package:weather_test/features/weather/data/models/weather_model.dart';

abstract interface class WeatherRemoteDataSource {
  const WeatherRemoteDataSource();

  Future<WeatherModel> getWeatherByCoordinates(
    double latitude,
    double longitude,
  );
}

class OpenWeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio _dio;
  final DotEnv _dotenv;

  const OpenWeatherRemoteDataSourceImpl({
    required Dio dio,
    required DotEnv dotenv,
  })  : _dio = dio,
        _dotenv = dotenv;

  @override
  Future<WeatherModel> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    final key = _dotenv.env[Constants.openWeatherApiKey];

    final response = await _dio.get(
      '/data/2.5/weather',
      queryParameters: {
        'lat': latitude,
        'lon': longitude,
        'units': 'metric',
        'appid': key,
      },
    );

    return WeatherModel.fromMap(response.data);
  }
}
