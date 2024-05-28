import 'dart:async';

import 'package:weather_test/core/base/base_usecase.dart';
import 'package:weather_test/features/city/domain/entities/city_entity.dart';
import 'package:weather_test/features/city/domain/repositories/city_repository.dart';

class GetCitiesByKeyWordUseCase implements BaseUseCase<List<CityEntity>, String> {
  final CityRepository _cityRepository;

  const GetCitiesByKeyWordUseCase({
    required CityRepository cityRepository,
  }) : _cityRepository = cityRepository;

  @override
  Future<List<CityEntity>> call(String keyword) {
    return _cityRepository.getCitiesByKeyword(keyword);
  }
}
