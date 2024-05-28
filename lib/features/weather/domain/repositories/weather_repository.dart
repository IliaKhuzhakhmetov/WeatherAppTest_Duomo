import 'package:weather_test/features/weather/domain/entities/weather_entity.dart';

abstract interface class WeatherRepository {
  Future<WeatherEntity> getWeatherByCoordinates(
    double latitude,
    double longitude,
  );
}
