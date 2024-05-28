import 'package:weather_test/core/base/base_mapper.dart';
import 'package:weather_test/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_test/features/weather/data/models/weather_model.dart';
import 'package:weather_test/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_test/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _weatherRemoteDataSource;

  final EntityMapper<WeatherEntity, WeatherModel> _weatherEntityMapper;

  const WeatherRepositoryImpl({
    required WeatherRemoteDataSource weatherRemoteDataSource,
    required EntityMapper<WeatherEntity, WeatherModel> weatherEntityMapper,
  })  : _weatherRemoteDataSource = weatherRemoteDataSource,
        _weatherEntityMapper = weatherEntityMapper;

  @override
  Future<WeatherEntity> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    final result = await _weatherRemoteDataSource.getWeatherByCoordinates(
      latitude,
      longitude,
    );

    return _weatherEntityMapper.toEntity(result);
  }
}
