import 'package:weather_test/core/base/base_mapper.dart';
import 'package:weather_test/features/weather/data/models/weather_model.dart';
import 'package:weather_test/features/weather/domain/entities/weather_entity.dart';

class WeatherEntityMapper implements EntityMapper<WeatherEntity, WeatherModel> {
  @override
  WeatherEntity toEntity(WeatherModel map) {
    return WeatherEntity(
      temperature: map.main.temp,
    );
  }
}
