import 'package:weather_test/features/city/domain/entities/city_entity.dart';

abstract interface class CityRepository {
  Future<List<CityEntity>> getCitiesByKeyword(String keyword);
}
