import 'package:dio/dio.dart';
import 'package:weather_test/features/city/data/models/cities_model.dart';

abstract interface class CityRemoteDataSource {
  Future<CitiesModel> getCitiesByKeyword(String keyword);
}

class AmadeusCityRemoteDataSource implements CityRemoteDataSource {
  final Dio _dio;

  const AmadeusCityRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<CitiesModel> getCitiesByKeyword(String keyword) async {
    final result = await _dio.get(
      '/v1/reference-data/locations/cities',
      queryParameters: {
        'keyword': keyword,
      },
    );

    return CitiesModel.fromMap(result.data);
  }
}
