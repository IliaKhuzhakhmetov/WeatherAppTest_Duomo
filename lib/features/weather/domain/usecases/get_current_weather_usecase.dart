import 'dart:async';

import 'package:weather_test/core/base/base_usecase.dart';
import 'package:weather_test/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_test/features/weather/domain/repositories/weather_repository.dart';

typedef GetCurrentWeatherParams = ({double latitude, double longitude});

class GetCurrentWeatherUseCase implements BaseUseCase<WeatherEntity, GetCurrentWeatherParams> {
  final WeatherRepository _weatherRepository;

  const GetCurrentWeatherUseCase({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository;

  @override
  Future<WeatherEntity> call(GetCurrentWeatherParams params) {
    return _weatherRepository.getWeatherByCoordinates(
      params.latitude,
      params.longitude,
    );
  }
}
